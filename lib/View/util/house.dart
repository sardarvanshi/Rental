import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rantal/View/util/utisUi.dart';
Widget propertyList(
    BuildContext context,
    String imageurl,
    int price,
    String name,
    String place,
    double rating,
    ) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(

          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Image.network(
                imageurl,
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width - 20,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 16,
                left: MediaQuery.of(context).size.width - 130,
                child: Container(
                    height: 25.0,
                    width: 80.00,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: colorlist[2],
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
    ),
  );
}