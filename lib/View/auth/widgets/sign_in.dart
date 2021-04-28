import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/auth/widgets/sign_in_up_bar.dart';
import 'package:rantal/View/ui/HomePage.dart';
import 'package:rantal/Provider/AuthProvider.dart';
import 'package:rantal/View/util/forgetpass.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/userinfo_model.dart';
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
  String Email;
  String Password;
  bool isLoading = false;
  bool validate = false;
  bool isValid = false;

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        validate = true;
        isLoading = true;
      });
      print('Form is valid');
    } else {
      print('Form is invalid');
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
                      onChanged: (value) => Email = value,
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
                      onChanged: (value) => Password = value,
                      controller: passwordcontrol,
                      validator: (value) =>
                          value.isEmpty ? 'Enter Password' : null,
                      decoration: signInInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            fontSize: 20,
                            color: Palette.darkBlue,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => forgetPass()));
                        },
                      ),
                    ],
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: isLoading,
                    onPressed: () {
                      validateAndSave();
                      if (validate) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailControl.text.toString().trim(),
                          password: passwordcontrol.text.toString().trim(),
                        )
                            .then((value) {
                          print(value.user);
                          Fluttertoast.showToast(
                              msg: "Sign in  Successfully Created",
                              toastLength: Toast.LENGTH_SHORT);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                          isValid = true;
                          return true;
                        }).onError((error, stackTrace) {
                          setState(() {
                            isLoading = false;
                          });

                          return Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_LONG);
                        });

                        if (isValid) {
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
