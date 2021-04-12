import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rantal/View/auth/widgets/sign_in_up_bar.dart';
import 'package:rantal/View/ui/HomePage.dart';
//import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import '../../../config/palette.dart';
import '../../home.dart';
import 'decoration_functions.dart';
import 'title.dart';

class SignIn extends StatefulWidget {
  SignIn({
    Key key,
    @required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var passwordcontrol = TextEditingController();
  var emailControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validate = false;
  bool isValid=false;

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        validate = true;
      });
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  signinUser()async{
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(
        email:emailControl.value.toString(),
        password: passwordcontrol.value.toString(),
      );
      print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isValid = false;
      });
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final isSubmitting = context.isSubmitting();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: LoginTitle(
                title: 'Welcome\nBack',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: emailControl,
                      decoration: signInInputDecoration(hintText: 'Email'),
                      validator: (value) {
                        return value.isEmpty ? 'Please Enter Email' : null;
                      },
                    ),
                    /*EmailTextFormField(
                        decoration: signInInputDecoration(hintText: 'Email'),
                      ),*/
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: passwordcontrol,
                      validator: (value) =>
                          value.isEmpty ? 'Enter Password' : null,
                      decoration: signInInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: false,
                    onPressed: () {
                      validateAndSave();
                      if (validate) {
                        signinUser();
                        if(isValid) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                          // context.signInWithEmailAndPassword();
                        }
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onRegisterClicked?.call();
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Palette.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
