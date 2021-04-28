import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rantal/Provider/AuthProvider.dart';
import 'package:rantal/config/palette.dart';
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
  bool validate = false;
  bool isLoading = false;
  bool isValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> Mydata = Map<String, dynamic>();

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

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

  Future<void> PickDate() async {
    var picked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendar,
        context: context,
        fieldLabelText: "Date Of Birth",
        errorInvalidText: "Select Valid Date",
        initialDate: DateTime(2021),
        firstDate: DateTime(1947),
        lastDate: DateTime(DateTime.now().year));
    print(picked.toString());
    Mydata["Dob"] = picked;
  }

  @override
  Widget build(BuildContext context) {
    // final isSubmitting = context.isSubmitting();
    return Padding(
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
                      onChanged: (value) => Mydata["Firstname"] = value,
                      validator: (value) =>
                          value.isEmpty ? 'Enter First Name' : null,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration:
                          registerInputDecoration(hintText: 'First Name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      onChanged: (value) => Mydata["Lastname"] = value,
                      validator: (value) =>
                          value.isEmpty ? 'Enter Last Name' : null,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration:
                          registerInputDecoration(hintText: 'Last Name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Palette.orange),
                      onPressed: () {
                        PickDate();
                      },
                      child: Text(
                        "Date of Birth",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => Mydata["Contact"] = value,
                      validator: (value) =>
                          value.isEmpty ? 'Invalid value' : null,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration:
                          registerInputDecoration(hintText: "Contact No"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                        onChanged: (value) => Mydata["Email"] = value = value,
                        validator: (value) => !validateEmail(emailControl.text)
                            ? 'Enter Valid Email'
                            : null,
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
                      onChanged: (value) => Mydata["Password"] = value,
                      validator: (value) => !validateStructure(
                              passwordcontrol.text)
                          ? 'Password Must consits with Upper case,Lowercase\n,Digit and Special character'
                          : null,
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
                    isLoading: isLoading,
                    onPressed: () {
                      validateAndSave();
                      print(context.read<AuthenticationProvider>().isRegister);
                      if (validate) {
                        try {
                          List<String> Recent = [];
                          //print(emailControl.text.toString());
                          //print(passwordcontrol.text.toString());
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailControl.text.toString().trim(),
                            password: passwordcontrol.text.toString().trim(),
                          )
                              .then((value) {
                            print(value.user.email);
                            FirebaseFirestore.instance
                                .collection("user")
                                .doc(value.user.uid)
                                .set({
                              "profile": Mydata,
                              "recentSearch": Recent
                            }).then((value) {
                              Fluttertoast.showToast(
                                  msg: "Account Successfully Created",
                                  toastLength: Toast.LENGTH_SHORT);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AuthScreen()));
                              setState(() {
                                isValid = true;
                              });
                            }).onError((error, stackTrace) =>
                                    Fluttertoast.showToast(
                                        msg: error.toString(),
                                        toastLength: Toast.LENGTH_LONG));
                          }).onError((error, stackTrace) =>
                                  Fluttertoast.showToast(
                                      msg: error.toString(),
                                      toastLength: Toast.LENGTH_LONG));
                        } on FirebaseAuthException catch (e) {
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
                        print(isValid);
                        print(
                            context.read<AuthenticationProvider>().getRefister);
                        setState(() {
                          isLoading = isValid;
                        });
                        print("done");
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
                          color: Palette.darkBlue,
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
