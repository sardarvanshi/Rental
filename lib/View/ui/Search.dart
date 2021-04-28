import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/util/Addresssearch.dart';
import 'package:rantal/View/util/house.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:rantal/model/SearchModel.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:uuid/uuid.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/admindata.dart';

class searchPage extends SearchDelegate {
  final List<dynamic> searchlist;
  String selectedResult;

  searchPage({this.recentList, this.searchlist});

  List<dynamic> recentList;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: () {
            query = "";
          })
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    print(1);
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          print(recentList);
          final uid = context.read<User>().uid;
          FirebaseFirestore.instance
              .collection('user')
              .doc(uid)
              .update({"recentSearch": recentList.reversed.toList()});
          context.read<userinfo>().fetchUserdata();
          Navigator.pop(context);
        });
    throw UnimplementedError();
  }

  bool isReturn;

  @override
  Widget buildResults(BuildContext context) {
    print(2);
    final user = context.read<User>();
    /*if(!recentList.contains(query)){
    print(":::::::");
    Provider.of<userinfo>(context,listen: false).handle_recentSearchhandler(query,recentList);
  }*/
    print(query + "........");
    print(recentList.toString() + "............");
    return WillPopScope(
      onWillPop: () async {
        print("POP");
        return true;
      },
      child: Container(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('properties')
            .where("Location", arrayContains: query)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text("No Data Found"),
              );
            }
            print(snapshot.data.docs.length);
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var result = snapshot.data.docs.elementAt(index);
                  return buildVerticalItem(context, index, result);
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(3);
    print(recentList);
    List<dynamic> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList
            .addAll(searchlist.where((element) => element.contains(query)));
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index]),
            onTap: () {
              query = suggestionList.elementAt(index);
              selectedResult = suggestionList.elementAt(index);
              if (recentList.length <= 5) {
                if (!recentList.contains(selectedResult)) {
                  recentList = recentList.reversed.toList();
                  print("------" + recentList.toString());
                  recentList.add(selectedResult);
                  print(recentList);
                  recentList = recentList.reversed.toList();
                  print(recentList);
                } else {
                  recentList.toSet().toList();
                  recentList.remove(selectedResult);
                  recentList = recentList.reversed.toList();
                  print("------" + recentList.toString());
                  recentList.add(selectedResult);
                  print(recentList);
                  recentList = recentList.reversed.toList();
                  print(recentList);
                }
              } else {
                recentList = recentList.reversed.toList();
                recentList.removeAt(0);
                print(recentList);
                recentList = recentList.reversed;

                if (!recentList.contains(selectedResult)) {
                  recentList = recentList.reversed.toList();
                  print("------" + recentList.toString());
                  recentList.add(selectedResult);
                  print(recentList);
                  recentList = recentList.reversed.toList();
                  print(recentList);
                } else {
                  recentList.toSet().toList();
                  recentList.remove(selectedResult);
                  recentList = recentList.reversed.toList();
                  print("------" + recentList.toString());
                  recentList.add(selectedResult);
                  print(recentList);
                  recentList = recentList.reversed.toList();
                  print(recentList);
                }
              }
              showResults(context);
            },
          );
        });
  }
}

//AIzaSyB653pCTSjptn5D5xpTGcUZcPkTHsa2u4c