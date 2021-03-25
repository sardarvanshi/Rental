import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rantal/View/util/house.dart';
import 'package:rantal/View/util/pdetail.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  Widget _body = Center(child:CircularProgressIndicator());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<dynamic> list;

  void getfav()  async {
    await firebaseFirestore
        .collection("user")
        .doc("0001uid")
        .get()
        .then((value) {
      setState(() {
        list = value.data()['favorites'];
      });
      if (list.isEmpty) {
        setState(() {
          _body = CircularProgressIndicator();
        });
      } else {
        setState(() => _body = fav());
      }
      print(list);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfav();

  }


  Widget fav() {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (contex, index) {

          return StreamBuilder(
              stream: firebaseFirestore
                  .collection("properties")
                  .doc(list.elementAt(index))
                  .snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  var result = snapshot.data;
                  print(result['city']);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyDetail(result)));
                    },
                    child: propertyList(
                      context,
                      result['image'],
                      result['rprice'],
                      result['name'],
                      result['city'],
                      result['rate'],
                    ),

                  );
                }
                return CircularProgressIndicator();
              });
        },
      ),
    ),
  );

}

  @override
  Widget build(BuildContext context) {
    return _body;
  }

}
