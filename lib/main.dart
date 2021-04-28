import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rantal/Provider/AuthProvider.dart';
import 'package:rantal/View/ui/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rantal/View/ui/disconnectedPage.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';
import 'package:rantal/View/ui/HomePage.dart';

import 'View/auth/auth.dart';
import 'View/ui/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var _lastQuitTime;
  //initialize firebase app
  await Firebase.initializeApp();
  // await dp.fetchUserdata();
  runApp(WillPopScope(
      onWillPop: () async {
        if (_lastQuitTime == null || _lastQuitTime <= 1) {
          print('Press again Back Button exit');
          print(_lastQuitTime);
          _lastQuitTime += 1;
          return false;
        } else {
          print('sign out');
          return true;
        }
      },
      child: MyApp()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey,
    statusBarBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  DateTime _lastQuitTime;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<userinfo>(create: (_) => userinfo(context)),
        Provider<adminData>(create: (_) => adminData()),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rantal',
        theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.white,
          //primarySwatch: AppbarIconColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Auth(),
      ),
    );
  }
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return MyHomePage();
    }
    return AuthScreen();
  }
}
