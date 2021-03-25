import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/utisUi.dart';

class MyDetail extends StatefulWidget {
  var result;

  MyDetail(this.result);

  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool fav = false;
  bool isRated = false;
  Icon favcon = Icon(
    Icons.favorite_border,
    color: Colors.white,
  );

  double rate;

  void checkfav() async {
    await firebaseFirestore
        .collection("user")
        .where("favorites", arrayContains: widget.result.id)
        .get()
        .then((value) {
      setState(() {
        fav = value.docs.isNotEmpty;
      });

      print(fav);
    });
  }

  void checkRating() async {
    await firebaseFirestore
        .collection("user")
        .where("rating", arrayContains: widget.result.id)
        .get()
        .then((value) {
      setState(() {
        isRated = value.docs.isNotEmpty;
      });

      print(fav);
    });
  }

  void ratingHandler(double rate) {
    firebaseFirestore.collection("properties").doc(widget.result.id).update({
      "rate": widget.result['rate'] + rate,
      "rcount": widget.result['rcount'] + 1,
    });
    firebaseFirestore.collection("user").doc("0001uid").update({
        "rating" : FieldValue.arrayUnion([widget.result.id]),
    });
    setState(() {
      rate = widget.result['rate'] / widget.result['rcount'];
    });
    print(widget.result['rate']);
  }

  void favoritehandle() {
    firebaseFirestore.collection("user").doc("0001uid").update({
      "favorites": FieldValue.arrayUnion([widget.result.id]),
    });
    print(widget.result['rate']);
  }

  void favoritefalsehandle() {
    firebaseFirestore.collection("user").doc("0001uid").update({
      "favorites": FieldValue.arrayRemove([widget.result.id]),
    });
    print(widget.result.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkfav();
    rate = widget.result['rate'] / widget.result['rcount'];
    checkRating();
    print(fav.toString() + "------");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                        height: 300.0,
                        child: Stack(
                          children: <Widget>[
                            Carousel(
                              images: [
                                NetworkImage(widget.result['image']),
                                // Photo from https://unsplash.com/photos/561igiTyvSk
                                NetworkImage(widget.result['image']),
                                // Photo from https://unsplash.com/photos/xpDHTc-pkog
                                NetworkImage(widget.result['image']),
                                // Photo from https://unsplash.com/photos/KtOid0FLjqU
                                NetworkImage(widget.result['image']),
                                // Photo from https://unsplash.com/photos/Luh5Pjxg_Vs
                                NetworkImage(widget.result['image']),
                                // Photo from https://unsplash.com/photos/BVd8jS5H7VU
                              ],
                              dotSize: 4.0,
                              dotSpacing: 15.0,
                              autoplay: false,
                              dotColor: Colors.white,
                              indicatorBgPadding: 50.0,
                              dotBgColor: Colors.transparent,
                              borderRadius: false,
                              moveIndicatorFromBottom: 200.0,
                              noRadiusForIndicator: true,
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 270, left: 20, right: 20),
                      child: Container(
                          height: 100.0,
                          width: MediaQuery.of(context).size.width - 24.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: colorlist[2],
                            /*boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.0,
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2.0)
                                  ]*/
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 50,
                                  color: colorlist[1],
                                ),
                                Text("Map View"),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Divider(),
                isRated
                    ? RatingBarIndicator(
                        itemSize: 30.0,
                        rating: rate,
                        itemBuilder: (context, _) => Icon(
                          Icons.star_rounded,
                          color: colorlist[1],
                        ),
                      )
                    : RatingBar.builder(
                        initialRating: rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_rounded,
                          color: colorlist[1],
                        ),
                        onRatingUpdate: (rating) {
                          ratingHandler(rating);
                        },
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.result['rprice']} Rs/${widget.result['term']}',
                    style: Propertyname,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      widget.result['name'] + widget.result['rate'].toString(),
                      style: term),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15, left: 14),
                  child: Text(
                    'About',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                about_hotel(widget.result['about']),
                about_hotel(widget.result['about']),
                about_hotel(widget.result['about']),
                about_hotel(widget.result['about']),
                about_hotel(widget.result['about']),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: CircleAvatar(
                    backgroundColor: colorlist[2],
                    child: fav
                        ? IconButton(
                            icon: Icon(Icons.favorite),
                            color: colorlist[1],
                            onPressed: () {
                              favoritefalsehandle();
                              setState(() {
                                // fav? favcon = Icon(Icons.favorite,color: colorlist[1],):favcon = Icon(Icons.favorite_border,color:Colors.white);
                                fav ? fav = false : fav = true;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.favorite_border),
                            color: Colors.white,
                            onPressed: () {
                              favoritehandle();
                              setState(() {
                                //  fav? favcon = Icon(Icons.favorite,color: colorlist[1],):favcon = Icon(Icons.favorite_border,color:Colors.white);
                                fav ? fav = false : fav = true;
                              });
                            },
                          ),
                  ),
                ),
              ],
            ),
            BookNow(),
          ],
        ),
      )),
    );
  }

  Widget about_hotel(
    String description,
  ) {
    return Padding(
        padding: EdgeInsets.only(left: 14, top: 6, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              description,
              style: about,
            ),
          ],
        ));
  }
}

class BookNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment(0.0, 1.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorlist[1],
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: OutlinedButton(
                      child: Text(
                        "Call",
                        style: TextStyle(color: colorlist[1]),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: colorlist[1],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: MaterialButton(
                      child: Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
