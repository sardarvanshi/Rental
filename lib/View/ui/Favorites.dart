import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/util/house.dart';
import 'package:rantal/View/util/pdetail.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/model/userinfo_model.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  Widget _body = Center(child:CircularProgressIndicator());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<dynamic> list;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
Future<void> RefreshHandler(userinfo user) async{
  await user.fetchUserdata();
  setState(() {
    list=user.favorites;
  });
}

  Widget fav(BuildContext context) {


}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userinfo>(context);
    list=user.favorites;
    return Scaffold(
      body: RefreshIndicator(
        color: colorlist[1],

        onRefresh: ()=> RefreshHandler(user),
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
      ),
    );
  }

}
