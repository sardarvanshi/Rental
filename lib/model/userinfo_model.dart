import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:rantal/Provider/AuthProvider.dart';

class userinfo extends ChangeNotifier {
  BuildContext context;

  userinfo(this.context);

  String uid;
  List<dynamic> recentSearch = [];
  String name = "hello  jd";
  List<dynamic> favorites = [];
  Map<String, dynamic> rating;
  int rows;
  String email = "";
  List<dynamic> Rateid;
  Favorites postproperties;
  GeoPoint geoPoint;

  fetchUserdata() async {
    final user = context.watch<User>();
    this.uid = user.uid;
    FirebaseFirestore MyfirestoreInstance = FirebaseFirestore.instance;

    await MyfirestoreInstance.collection('user')
        .doc(user.uid)
        .get()
        .then((value) {
      var result = value.data()['profile'];
      // print(result);
      name = result['Firstname'];
      recentSearch = value.data()['recentSearch'];
      favorites = result['Favorites'];
      Rateid = result['Review'];
      //Rateid = rating.keys.toList();
      email = result['Email'];
      notifyListeners();
      printdata();
      //userInfo = userinfo.fromJson(value.data());
      // print(un.name??"hello");
    });
  }

  printdata() {
    print(name);
    print(uid);
    print(email);
    print(favorites);
  }

  Favorites_handler(String query) {
    favorites.add(query);
  }

  pr() {
    print(recentSearch.toString() +
        ".....................................................");
  }

  handle_recentSearchhandler(String query, List recent) {
    print(recentSearch.length);

    if (query.isNotEmpty) {
      if (recent.length >= 5) {
        recent.removeAt(0);
        print(recent);
        recent.add(6);
        print(recent.reversed);
        print("++++" + recentSearch.length.toString() + "+++");
        recentSearch.add(query);
        notifyListeners();
      } else {
        print(recentSearch.length);
        recentSearch.add(query);
        notifyListeners();
      }
    }
  }

  recentSearchUpdate(List<dynamic> value) {
    print("Done");
    print(uid);
    print(recentSearch);
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({"recentSearch": value});
  }

/* userinfo.fromJson(Map<String, dynamic> json) {
    print("IN USERINFO");
    this.name = json['name'];
    print(name);
    favorites = json['favorites'] != null
        ? new Favorites.fromJson(json['favorites'])
        : null;
    rows = json['rows'];
    email = json['Email'];
    geoPoint = json["location"];
    postproperties = json['postproperties'] != null
        ? new Favorites.fromJson(json['postproperties'])
        : null;
  }*/

/* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.favorites != null) {
      data['favorites'] = this.favorites.toJson();
    }
    data['rows'] = this.rows;
    data['Email'] = this.email;
    if (this.postproperties != null) {
      data['postproperties'] = this.postproperties.toJson();
    }
    return data;
  }*/
}

class Favorites {
  List pid;

  Favorites({this.pid});

  Favorites.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    return data;
  }
}