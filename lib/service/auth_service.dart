import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../helper/helper_function.dart';
import 'database_service.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // signup
  Future signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signin
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(user.uid).savingUserData(email, password);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  // Future<void> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   final credential = FacebookAuthProvider.credential(result.accessToken!.token);
  //   await _auth.signInWithCredential(credential);
  // }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
