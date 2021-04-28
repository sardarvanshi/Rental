import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/util/house.dart';
import 'package:rantal/View/util/pdetail.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/config/palette.dart';
import 'package:rantal/model/userinfo_model.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Widget _body = Center(child: CircularProgressIndicator());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<dynamic> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> RefreshHandler() async {
    await context.read<userinfo>().fetchUserdata();
    setState(() {
      list = context.watch<userinfo>().favorites;
      print(list);
    });
  }

  Widget fav(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    list = context.read<userinfo>().favorites;
    return Scaffold(
      body: RefreshIndicator(
        color: colorlist[1],
        onRefresh: () => RefreshHandler(),
        child: Padding(
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
                    if (snapshot.hasData) {
                      var result = snapshot.data;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDetail(result)));
                        },
                        child: buildVerticalItem(context, index, result),
                      );
                    } else {}
                    return Center(
                        child: CircularProgressIndicator(
                      semanticsLabel: "Loading",
                    ));
                  });
            },
          ),
        ),
      ),
    );
  }
}
