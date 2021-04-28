import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rantal/View/ui/Propety_detail.dart';
import 'package:rantal/View/util/pdetail.dart';
import 'package:rantal/View/util/house.dart';

class PropetyList extends StatefulWidget {
  @override
  _PropetyListState createState() => _PropetyListState();
}

class _PropetyListState extends State<PropetyList> {
  FirebaseFirestore MyFirebaseFirestore = FirebaseFirestore.instance;
  QuerySnapshot documentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: MyFirebaseFirestore.collection('properties').snapshots(),
            // stream: MyFirebaseFirestore.collection("properties").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var result = snapshot.data.docs.elementAt(index);
                      print(result);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDetail(result)));
                        },
                        child: buildVerticalItem(context, index, result),
                      );
                    });
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
