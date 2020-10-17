import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messio/config/Constants.dart';
import 'BaseProviders.dart';

class AuthenticationProvider extends BaseAuthenticationProvider {
  GoogleSignInAccount googleUser;
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;

  AuthenticationProvider({FirebaseAuth auth, GoogleSignIn googleSignIn});

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final usercredentials =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return usercredentials.user;
  }

  @override
  Future<void> signOutUser() async {
    print('firebaseauth $auth');
    await auth.signOut();
    await googleSignIn.signOut();
  }

  @override
  Future<User> getCurrentUser() async {
    return await auth.currentUser; //retrieve the current user
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await auth.currentUser; //check if user is logged in or not
    return user != null;
  }

  @override
  void dispose() {}
}
