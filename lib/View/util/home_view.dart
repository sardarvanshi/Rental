import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rantal/View/util/pdetail.dart';
import 'package:rantal/View/util/utisUi.dart';

import 'Property_DetailView.dart';

class cslider extends StatefulWidget {
  AsyncSnapshot snapshot;

  cslider(this.snapshot);

  @override
  _csliderState createState() => _csliderState();
}

class _csliderState extends State<cslider> {
  List<String> listImages = [
    "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1472224371017-08207f84aaae?crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1523217582562-09d0def993a6?crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1577552568192-467a12a7f376?crop&w=1050&q=80"
  ];

  _buildItem(BuildContext context, int index, result) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      height: 100,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(0.0, 3.0),
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2.0,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                result['Property']['Images'].elementAt(0),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            result['Location'].elementAt(1).toString(),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Text(result['Location'].elementAt(0).toString(),
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 360,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var result = widget.snapshot.data.docs.elementAt(index);

              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Detail()));
                },
                child: _buildItem(context, index, result),
                /*house(
                  result['image'],
                  result['rprice'].toString(),
                  "any",
                  result['city'],
                  result['rate'].toDouble(),
                ),*/
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

Widget house(
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
