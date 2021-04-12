import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import '../auth.dart';
import 'decoration_functions.dart';
import 'sign_in_up_bar.dart';
import 'title.dart';

class Register extends StatefulWidget {
  const Register({Key key, this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var passwordcontrol = TextEditingController();
  var emailControl = TextEditingController();
  bool validate=false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  bool validateEmail(String value){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
  }
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

  createUser()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailControl.value.toString(),
        password: passwordcontrol.value.toString(),
      );
      print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isSubmitting = context.isSubmitting();
    return  Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: LoginTitle(
                title: 'Create\nAccount',
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
                        validator: (value)=>
                        !validateEmail(emailControl.text)? 'Enter Valid Email':null,
                      controller: emailControl,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: registerInputDecoration(hintText: 'Email')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(

                      validator: (value)=>
                      !validateStructure(passwordcontrol.text)? 'Password Must consits with Upper case,Lower case,Digit and Special character':null,
                      controller: passwordcontrol,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration: registerInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignUpBar(
                    label: 'Sign up',
                    isLoading: false,
                    onPressed: () {
                      validateAndSave();
                      if(validate) {
                        createUser();
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            AuthScreen()));
                        //context.registerWithEmailAndPassword();
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onSignInPressed?.call();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
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
