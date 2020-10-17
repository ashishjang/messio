import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messio/config/Constants.dart';
import 'package:messio/config/Paths.dart';
import 'package:messio/models/Contact.dart';
import 'package:messio/models/User.dart';
import 'package:messio/providers/BaseProviders.dart';
import 'package:messio/utils/Exceptions.dart';
import 'package:messio/utils/SharedObjects.dart';

class UserDataProvider extends BaseUserDataProvider {
  final FirebaseFirestore fireStoreDb;

  UserDataProvider({FirebaseFirestore fireStoreDb})
      : fireStoreDb = fireStoreDb ?? FirebaseFirestore.instance;

  @override
  Future<UserData> saveDetailsFromGoogleAuth(User user) async {
    DocumentReference ref = fireStoreDb.collection(Paths.usersPath).doc(user
        .uid); //reference of the user's document node in database/users. This node is created using uid
    final bool userExists =
        !await ref.snapshots().isEmpty; // check if user exists or not
    var data = {
      //add details received from google auth
      'uid': user.uid,
      'email': user.email,
      'name': user.displayName,
    };
    if (!userExists && user.photoURL != null) {
      // if user entry exists then we would not want to override the photo url with the one received from googel auth
      data['photoUrl'] = user.photoURL;
    }
    ref.set(data); // set the data
    final DocumentSnapshot currentDocument =
        await ref.get(); // get updated data reference
    await SharedObjects.prefs
        .setString(Constants.sessionUsername, user.displayName);
    return UserData.fromFirestore(
        currentDocument); // create a user object and return
  }

  @override
  Future<UserData> saveProfileDetails(
      String profileImageUrl, int age, String username) async {
    String uid = SharedObjects.prefs.getString(Constants.sessionUid);
    //get a reference to the map
    DocumentReference mapReference =
        fireStoreDb.collection(Paths.usernameUidMapPath).doc(username);
    var mapData = {'uid': uid};
    //map the uid to the username
    mapReference.set(mapData);

    DocumentReference ref = fireStoreDb.collection(Paths.usersPath).doc(
        uid); //reference of the user's document node in database/users. This node is created using uid
    var data = {
      'photoUrl': profileImageUrl,
      'age': age,
      'username': username,
    };
    await ref.set(data); // set the photourl, age and username
    final DocumentSnapshot currentDocument =
        await ref.get(); // get updated data back from firestore
    await SharedObjects.prefs.setString(Constants.sessionUsername, username);
    await SharedObjects.prefs.setString(
        Constants.sessionProfilePictureUrl, currentDocument.data()['photoUrl']);
    return UserData.fromFirestore(
        currentDocument); // create a user object and return it
  }

  @override
  Future<void> updateProfilePicture(String profilePictureUrl) async {
    String uid = SharedObjects.prefs.getString(Constants.sessionUid);
    DocumentReference ref = fireStoreDb.collection(Paths.usersPath).doc(
        uid); //reference of the user's document node in database/users. This node is created using uid
    var data = {
      'photoUrl': profilePictureUrl,
    };
    await ref.set(data); // set the photourl
  }

  @override
  Future<bool> isProfileComplete() async {
    DocumentReference ref = fireStoreDb.collection(Paths.usersPath).doc(
        SharedObjects.prefs.getString(
            Constants.sessionUid)); // get reference to the user/ uid node
    final DocumentSnapshot currentDocument = await ref.get();
    final bool isProfileComplete = currentDocument != null &&
        currentDocument.exists &&
        currentDocument.data().containsKey('photoUrl') &&
        currentDocument.data().containsKey('username') &&
        currentDocument.data().containsKey(
            'age'); // check if it exists, if yes then check if username and age field are there or not. If not then profile incomplete else complete
    if (isProfileComplete) {
      await SharedObjects.prefs.setString(
          Constants.sessionUsername, currentDocument.data()['username']);
      await SharedObjects.prefs
          .setString(Constants.sessionName, currentDocument.data()['name']);
      await SharedObjects.prefs.setString(Constants.sessionProfilePictureUrl,
          currentDocument.data()['photoUrl']);
    }
    return isProfileComplete;
  }

  @override
  Stream<List<Contact>> getContacts() {
    CollectionReference userRef = fireStoreDb.collection(Paths.usersPath);
    DocumentReference ref =
        userRef.doc(SharedObjects.prefs.getString(Constants.sessionUid));
    return ref.snapshots().transform(
        StreamTransformer<DocumentSnapshot, List<Contact>>.fromHandlers(
            handleData: (documentSnapshot, sink) =>
                mapDocumentToContact(userRef, ref, documentSnapshot, sink)));
  }

  void mapDocumentToContact(CollectionReference userRef, DocumentReference ref,
      DocumentSnapshot documentSnapshot, Sink sink) async {
    List<String> contacts;

    if (documentSnapshot.data()['contacts'] == null ||
        documentSnapshot.data()['chats'] == null) {
      ref.update({'contacts': []});
      contacts = List();
    } else {
      contacts = List.from(documentSnapshot.data()['contacts']);
    }
    List<Contact> contactList = List();
    Map chats = documentSnapshot.data()['chats'];
    for (String username in contacts) {
      String uid = await getUidByUsername(username);
      DocumentSnapshot contactSnapshot = await userRef.doc(uid).get();
      contactSnapshot.data()['chatId'] = chats[username];
      contactList.add(Contact.fromFirestore(contactSnapshot));
    }
    contactList.sort((a, b) => a.name.compareTo(b.name));
    sink.add(contactList);
  }

  @override
  Future<void> addContact(String username) async {
    UserData contactUser = await getUser(username);
    //create a node with the username provided in the contacts collection
    CollectionReference collectionReference =
        fireStoreDb.collection(Paths.usersPath);
    DocumentReference ref = collectionReference
        .doc(SharedObjects.prefs.getString(Constants.sessionUid));

    //await to fetch user details of the username provided and set data
    final documentSnapshot = await ref.get();
    List<String> contacts = documentSnapshot.data()['contacts'] != null
        ? List.from(documentSnapshot.data()['contacts'])
        : List();
    if (contacts.contains(username)) {
      throw ContactAlreadyExistsException();
    }
    //add contact
    contacts.add(username);
    await ref.set({'contacts': contacts});
    //contact should be added in the contactlist of both the users. Adding to the second user here
    String sessionUsername =
        SharedObjects.prefs.getString(Constants.sessionUsername);
    DocumentReference contactRef =
        collectionReference.doc(contactUser.documentId);
    final contactSnapshot = await contactRef.get();
    contacts = contactSnapshot.data()['contacts'] != null
        ? List.from(contactSnapshot.data()['contacts'])
        : List();
    if (contacts.contains(sessionUsername)) {
      throw ContactAlreadyExistsException();
    }
    contacts.add(sessionUsername);
    await contactRef.set({'contacts': contacts});
  }

  @override
  Future<UserData> getUser(String username) async {
    String uid = await getUidByUsername(username);
    DocumentReference ref = fireStoreDb.collection(Paths.usersPath).doc(uid);
    DocumentSnapshot snapshot = await ref.get();
    if (snapshot != null && snapshot.exists) {
      return UserData.fromFirestore(snapshot);
    } else {
      throw UserNotFoundException();
    }
  }

  @override
  Future<String> getUidByUsername(String username) async {
    //get reference to the mapping using username
    DocumentReference ref =
        fireStoreDb.collection(Paths.usernameUidMapPath).doc(username);
    DocumentSnapshot documentSnapshot = await ref.get();
    //check if uid mapping for supplied username exists
    if (documentSnapshot != null &&
        documentSnapshot.exists &&
        documentSnapshot.data()['uid'] != null) {
      return documentSnapshot.data()['uid'];
    } else {
      throw UsernameMappingUndefinedException();
    }
  }

  @override
  void dispose() {}
}
