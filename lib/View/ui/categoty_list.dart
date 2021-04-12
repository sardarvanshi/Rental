import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rantal/View/ui/Propety_detail.dart';
import 'package:rantal/View/util/pdetail.dart';
import '../util/house.dart';

class Category_List extends StatefulWidget {
  String Category;

  Category_List(this.Category);

  @override
  _Category_ListState createState() => _Category_ListState();
}

class _Category_ListState extends State<Category_List> {
  FirebaseFirestore MyFirebaseFirestore = FirebaseFirestore.instance;
  QuerySnapshot documentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: MyFirebaseFirestore.collection('properties')
                .where("type", isEqualTo: widget.Category)
                .snapshots(),
            // stream: MyFirebaseFirestore.collection("properties").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var result = snapshot.data.docs.elementAt(index);
                      print(result);
                      if(snapshot.data.docs.length == 0){
                        return Center(child: Text("NO Data AVailable"),);
                      }
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
                    });
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
