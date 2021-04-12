import 'package:cloud_firestore/cloud_firestore.dart';

class adminData{

  List<dynamic> categoty;


  fetchAdmindata() async {
    FirebaseFirestore MyfirestoreInstance = FirebaseFirestore.instance;
    print("fetching data");
    await MyfirestoreInstance.collection('admin').doc('jd01').get().then((
        value) {
      var result = value.data();
      print(value.data());
      categoty = result['category'];

      //userInfo = userinfo.fromJson(value.data());
      // print(un.name??"hello");

    });
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
