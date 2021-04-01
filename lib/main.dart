import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/ui/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rantal/View/ui/disconnectedPage.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';

import 'View/ui/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize firebase app
  await Firebase.initializeApp();
 // await dp.fetchUserdata();
runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}

class MyApp extends StatelessWidget {
  userinfo uinfo = userinfo();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    uinfo.fetchUserdata();
    return Provider<userinfo>(
      create: (context) => uinfo,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rantal',
        theme: ThemeData(

          //primarySwatch: AppbarIconColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPageWidget(),
      ),
    );
  }
}

class MynoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rantal',
      theme: ThemeData(
        primaryColor: Colors.white,
       // primarySwatch: AppbarIconColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DisconnectedPage(),
    );
  }
}