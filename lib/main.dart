import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/ui/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rantal/View/ui/disconnectedPage.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';

import 'View/auth/auth.dart';
import 'View/ui/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _lastQuitTime;
  //initialize firebase app
  await Firebase.initializeApp();
 // await dp.fetchUserdata();
runApp(

    WillPopScope(
        onWillPop: ()async{
          if (_lastQuitTime == null ||
              _lastQuitTime <= 1) {
            print('Press again Back Button exit');
            print(_lastQuitTime);
            _lastQuitTime+=1;
            return false;
          } else {
            print('sign out');
            return true;
          }
        },
        child: MyApp()));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}

class MyApp extends StatelessWidget {
  userinfo uinfo = userinfo();
  adminData adData = adminData();
  DateTime _lastQuitTime;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    uinfo.fetchUserdata();
    adData.fetchAdmindata();
    return MultiProvider(
      providers:[
        Provider(create:(_)=> uinfo),
        Provider(create: (_)=>adData),
      ] ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rantal',
        theme: ThemeData(

          //primarySwatch: AppbarIconColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  AuthScreen()),

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