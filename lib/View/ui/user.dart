import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rantal/View/util/Mypost.dart';
import 'package:rantal/View/util/home_view.dart';
import 'package:rantal/bloc/userinfo_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';

class ProfilePage extends StatefulWidget {
  Color _iconColor = Colors.white;

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore MyFirebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userinfo>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 46.0,
                          backgroundImage: AssetImage("assets/images/logo2.jpg"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(height: 20),
                        Text(
                          user.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          user.email,
                          style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                top: 40.0,
                bottom: 30.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '173',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 17.0),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Post',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '1.2k',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 17.0),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '29k',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 17.0),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Views',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream:
                  MyFirebaseFirestore.collection('properties').where("uid",isEqualTo: "0002").snapshots(),
              // stream: MyFirebaseFirestore.collection("properties").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var id;
                  snapshot.data.docs.forEach((doc) {
                    id = doc.id;
                  });
                  print(id.toString() +
                      " +++++++++++++++********+++++++++++++++++");
                  return userproperty(snapshot);
                }else if(snapshot.data.isEmpty){
                  return Center(child: Text("No Data Available"),);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ));
  }
}
