import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rantal/View/ui/Search.dart';
import 'package:rantal/View/util/home_view.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/userinfo_model.dart';
import '../util/Home_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rantal/View/ui/Favorites.dart';
import 'package:rantal/View/ui/postproperties.dart';
import 'package:rantal/View/ui/property_list.dart';
import 'package:rantal/View/util/pdetail.dart';
import 'package:rantal/View/util/utisUi.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:backdrop/backdrop.dart';

import 'Propety_detail.dart';
import 'categoty_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  FirebaseFirestore MyFirebaseFirestore = FirebaseFirestore.instance;
  List<dynamic> searchList;

  void getList() {
    FirebaseFirestore.instance
        .collection('admin')
        .doc('jd01')
        .snapshots()
        .listen((event) {
      print(event.data()['Search']);
      setState(() {
        searchList = event.data()['Search'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  _buildSearchBar(recent) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(3.0, 3.0),
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
      child: InkWell(
        onTap: () {
          showSearch(
              context: context,
              delegate: searchPage(searchlist: searchList, recentList: recent));
        },
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Search",
                  style: GoogleFonts.robotoSlab(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            )),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var recent = Provider.of<userinfo>(context, listen: false)
        .recentSearch
        .reversed
        .toList();
    context.read<userinfo>().fetchUserdata();
    context.read<userinfo>().pr();
    context.read<adminData>().fetchAdmindata();
    return Theme(
      data: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: Color(0XFFEEF3F7),
          primaryColor: Colors.black87),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Discover\nProperties",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              _buildSearchBar(recent),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("New Properties",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff5dad92),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PropetyList()));
                      },
                      child: Text("More",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: MyFirebaseFirestore.collection('properties')
                    .limit(6)
                    .snapshots(),
                // stream: MyFirebaseFirestore.collection("properties").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var id;
                    snapshot.data.docs.forEach((doc) {
                      id = doc.id;
                    });
                    print(id.toString() +
                        " +++++++++++++++********+++++++++++++++++");
                    return cslider(snapshot);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
                child: Text("Recommended Properties",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              StreamBuilder(
                stream: MyFirebaseFirestore.collection('properties')
                    .limit(6)
                    .snapshots(),
                // stream: MyFirebaseFirestore.collection("properties").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return cslider(snapshot);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
/* return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(
          children: [
            _buildSearchBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("New Properties",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff5dad92),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PropetyList()));
                    },
                    child: Text("More",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: MyFirebaseFirestore.collection('properties')
                  .limit(6)
                  .snapshots(),
              // stream: MyFirebaseFirestore.collection("properties").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var id;
                  snapshot.data.docs.forEach((doc) {
                    id = doc.id;
                  });
                  print(id.toString() +
                      " +++++++++++++++********+++++++++++++++++");
                  return cslider(snapshot);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Categories",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff5dad92),
                  )),
            ),
            Categories(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Recomanded",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff5dad92),
                  )),
            ),
            StreamBuilder(
              stream: MyFirebaseFirestore.collection('properties')
                  .limit(6)
                  .snapshots(),
              // stream: MyFirebaseFirestore.collection("properties").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return cslider(snapshot);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(
              height: 100,
            )
            // cslider(),
          ],
        ),
      ),
    );*/

}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final Admin = Provider.of<adminData>(context);
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: Admin.categoty.length,
          itemBuilder: (_, index) {
            var result = Admin.categoty.elementAt(index);
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Category_List(result))),
              child: genre_moods(
                  'https://i.pinimg.com/originals/92/d3/e2/92d3e202bee3df35b5a65278158677c1.jpg',
                  result),
              /*Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              child: Stack(
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                        child:
              Image.network('https://images.unsplash.com/photo-1487975460695-a2e5c4ea12c9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',width: MediaQuery.of(context).size.width/3,fit: BoxFit.cover,)
              ),
                  ),
                  Center(
                    child: Text(result,style:GoogleFonts.notoSerif(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3134c3),
                    )),
                  )
                ],
              ),
            ),*/
            );
          }),
    );
  }
}
