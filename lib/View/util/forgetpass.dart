import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rantal/Provider/AuthProvider.dart';
import 'package:rantal/View/auth/auth.dart';
import 'package:rantal/View/auth/widgets/background_painter.dart';
import 'package:rantal/View/auth/widgets/decoration_functions.dart';
import 'package:rantal/View/auth/widgets/sign_in_up_bar.dart';
import 'package:rantal/View/auth/widgets/title.dart';
import 'package:rantal/config/palette.dart';
//import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'package:rantal/View/auth/widgets/register.dart';
import 'package:rantal/View/auth/widgets/sign_in.dart';

class forgetPass extends StatefulWidget {
  const forgetPass({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const forgetPass(),
      );

  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<bool>(
                valueListenable: showSignInPage,
                builder: (context, value, child) {
                  return SizedBox.expand(
                    child: PageTransitionSwitcher(
                        reverse: !value,
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: child,
                          );
                        },
                        child: ForgetPassword()),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var passwordcontrol = TextEditingController();
  var emailControl = TextEditingController();
  String Email;
  String Password;
  bool validate = false;
  bool isLoading = false;
  bool isValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                title: 'Reset\nPassword',
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
                      child: Text(
                        "Enter your Email ",
                        style: TextStyle(
                            color: Palette.darkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                        onChanged: (value) => Email = value,
                        validator: (value) => !validateEmail(emailControl.text)
                            ? 'Enter Valid Email'
                            : null,
                        controller: emailControl,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.orange),
                            hintText: 'Email')),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          validateAndSave();
                          isValid
                              ? await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailControl.text.trim())
                              : null;
                        },
                        child: Text("Send Email"),
                        style: ElevatedButton.styleFrom(
                            primary: Palette.darkOrange),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Palette.lightBlue,
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
