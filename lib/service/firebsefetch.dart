import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rantal/View/ui/user.dart';
import 'package:rantal/model/userinfo_model.dart';

//userinfo userInfo = userinfo();

class dataprovider {

  final FirebaseFirestore MyfirestoreInstance = FirebaseFirestore.instance;
  userinfo un ;

  //For getting user data from firebase
  fetchUserdata() async {
    print("fetching data");
    await MyfirestoreInstance.collection('user').doc('0001uid').get().then((
        value) {
      print(value.data()['name']);
      //userInfo = userinfo.fromJson(value.data());
     // print(un.name??"hello");

    });
  }

  //Retrive data
  /*Stream<userinfo> getUserList() {
    return MyfirestoreInstance.collection('user')
        .doc('0001uid').snapshots()
        .map((document) => userinfo.fromJson(document.data()));
  } */


  Stream<List> getPropertydata() {
    return MyfirestoreInstance.collection('user')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => print(document.data().length))
        .toList());
  }
  }

//For getting propertydata from firebase

