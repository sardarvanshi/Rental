import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rantal/View/ui/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rantal/View/ui/disconnectedPage.dart';
import 'package:rantal/View/util/utisUi.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //initialize firebase app
  await Firebase.initializeApp();
runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rantal',
      theme: ThemeData(

        //primarySwatch: AppbarIconColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
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