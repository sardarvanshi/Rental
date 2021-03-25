import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rantal/model/userinfo_model.dart';

userinfo un ;
class dataprovider {

  final FirebaseFirestore MyfirestoreInstance = FirebaseFirestore.instance;


  //For getting user data from firebase
   fetchUserdata() async {
    print("fetching data");

    await MyfirestoreInstance.collection('user').doc('0001uid').get().then((
        value) {
      print(value.data());
      return userinfo.fromJson(value.data());
    });
  }

  //Retrive data
  Stream<userinfo> getUserList() {
    return MyfirestoreInstance.collection('user')
        .doc('0001uid').snapshots()
        .map((document) => userinfo.fromJson(document.data()));
  }


  Stream<List> getPropertydata() {
    return MyfirestoreInstance.collection('user')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => print(document.data().length))
        .toList());
  }
  }

//For getting propertydata from firebase

