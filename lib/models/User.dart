import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String documentId;
  String name;
  String username;
  int age;
  String photoUrl;

  UserData(
      {this.documentId, this.name, this.username, this.age, this.photoUrl});

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return UserData(
        documentId: doc.id,
        name: data['name'],
        username: data['username'],
        age: data['age'],
        photoUrl: data['photoUrl']);
  }
  factory UserData.fromMap(Map data) {
    return UserData(
        documentId: data['uid'],
        name: data['name'],
        username: data['username'],
        age: data['age'],
        photoUrl: data['photoUrl']);
  }
  @override
  String toString() {
    return '{ documentId: $documentId, name: $name, age: $age, username: $username, photoUrl: $photoUrl }';
  }
}
