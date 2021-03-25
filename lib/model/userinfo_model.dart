import 'package:cloud_firestore/cloud_firestore.dart';

class userinfo {
  String name;
  Favorites favorites;
  int rows;
  String email;
  Favorites postproperties;
  GeoPoint geoPoint;

  userinfo(
      {this.name, this.favorites, this.rows, this.email, this.postproperties});

  userinfo.fromJson(Map<String, dynamic> json) {
    print("IN USERINFO");
    name = json['name'];
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
  }

  Map<String, dynamic> toJson() {
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
  }
}

class Favorites {
  String pid;

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