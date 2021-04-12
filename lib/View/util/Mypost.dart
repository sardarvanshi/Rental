import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rantal/View/util/pdetail.dart';
import 'package:rantal/View/util/utisUi.dart';


class userproperty extends StatefulWidget {
  AsyncSnapshot snapshot;

  userproperty(this.snapshot);

  @override
  _userpropertyState createState() => _userpropertyState();
}

class _userpropertyState extends State<userproperty> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: widget.snapshot.data.docs.length > 0?GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 12),
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
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(result['image']),
                      )
                  ),
                )
              );
            },
          ):
         Center(
           child:
           Text("No Data Availabe"),
         )
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
    int price,
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
                      price.toString(),
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

