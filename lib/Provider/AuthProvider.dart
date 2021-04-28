import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:rantal/View/auth/auth.dart';
import 'package:rantal/View/ui/HomePage.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isValid = false;
  bool isRegister = false;
  final FirebaseAuth firebaseAuth;

// FirebaseAuth instance
  AuthenticationProvider(this.firebaseAuth);

//Constructor to initialize the Firebase Auth instance.

  //listen for auth
  Stream<User> get authState => firebaseAuth.idTokenChanges();

  bool get getValid => isValid;

  bool get getRefister => isRegister;

  //Sign up
  /*bool createUser({String email, String password}){
    try {
      //print(emailControl.text.toString());
      //print(passwordcontrol.text.toString());
      firebaseAuth.createUserWithEmailAndPassword(
        email: email.toString().trim(),
        password: password.toString().trim(),
      ).then((value){
        print(value.user.email);
        isRegister = true;
        notifyListeners();
        print(isRegister);
        return true;
      }).onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString(),toastLength: Toast.LENGTH_LONG));

    } on FirebaseAuthException catch (e) {
      */ /*setState(() {
        isLoading=false;
        isValid=false;
      });*/ /*
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {

        Fluttertoast.showToast(msg: "Email Already in use");
        print('Account already exists for that email.');
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
    return false;
  }*/

  //sign in

/* bool signinUser({String email, String password}){
    try {
     firebaseAuth
          .signInWithEmailAndPassword(
        email:email.toString().trim(),
        password: password.toString().trim(),
      ).then((value) {
        print(value.user.emailVerified);
        isValid=true;
        return true;
      }).onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString(),toastLength: Toast.LENGTH_LONG));
      */ /*setState(() {
        isValid = true;
      });*/ /*



    } on FirebaseAuthException catch (e) {
      print(e);
      */ /*setState(() {
        isLoading=false;
      });*/ /*
      Fluttertoast.showToast(msg: e.toString());
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user Found for This Email");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }*/
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
