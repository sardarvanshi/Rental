import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
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

  void getid() {
    FirebaseFirestore.instance
        .collection('properties')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id + " ++++++++++++++++++++++++++++++++");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(
          children: [
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
              stream: MyFirebaseFirestore.collection('properties').snapshots(),
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
            StreamBuilder(
              stream: MyFirebaseFirestore.collection('catagories')
                  .doc('catid01')
                  .snapshots(),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Categories(snapshot);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
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
              stream: MyFirebaseFirestore.collection('properties').snapshots(),
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
    );
  }
}

class Categories extends StatefulWidget {
  AsyncSnapshot snapshot;

  Categories(this.snapshot);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.snapshot.data['catagories'].length,
          itemBuilder: (_, index) {
            var result = widget.snapshot.data['catagories'].elementAt(index);
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

class cslider extends StatefulWidget {
  AsyncSnapshot snapshot;

  cslider(this.snapshot);

  @override
  _csliderState createState() => _csliderState();
}

class _csliderState extends State<cslider> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 360,
          width: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var result = widget.snapshot.data.docs.elementAt(index);

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyDetail(result)));
                },
                child: hotels(
                  result['image'],
                  result['rprice'],
                  "any",
                  result['city'],
                  result['rate'].toDouble(),
                ),
              );
            },
          ),
        )
        /* CarouselSlider.builder(
            itemCount: widget.snapshot.data.docs.length,
            itemBuilder: (context,index,int){
              var result = widget.snapshot.data.docs.elementAt(index);
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyDetail(result)));
                },
                child:hotels(result['image'], result['rprice'], "any", result['city'],4, 'hello'),
              );
            },
            options:CarouselOptions(
              //height: 180.0,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
        ),*/

        );
  }
}

Widget hotels(
  String imageurl,
  String price,
  String name,
  String place,
  double rating,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(

              placeholder: (_,url) => Lottie.asset('assets/lotti/imageplace.json'),
             imageUrl: imageurl,
              height: 230,
              width: 230,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 16,
              left: 140,
              child: Container(
                  height: 25.0,
                  width: 80.00,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Color(0xff0F0F0F),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff0F0F0F).withOpacity(0.3),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      price,
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
      Padding(
        padding: EdgeInsets.only(left: 14),
        child: Text(
          name,
          style: GoogleFonts.robotoSlab(fontSize: 20),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 14),
        child: Text(
          place,
          style: GoogleFonts.robotoSlab(color: colorlist[2],fontSize: 15),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 14),
        child: Row(
          children: <Widget>[
            RatingBarIndicator(
              itemSize: 30.0,
              rating: rating,
              itemBuilder: (context, _) => Icon(
                Icons.star_rounded,
                color: colorlist[1],
              ),
            ),
          ],
        ),
      )
    ],
  );
}

stars(int rating, int index) {
  if (index <= rating) {
    return Icon(
      Icons.star,
      color: Colors.amber,
      size: 13.0,
    );
  } else {
    return Icon(Icons.star, color: Colors.grey, size: 13.0);
  }
}
