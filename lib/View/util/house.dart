import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rantal/View/util/utisUi.dart';

List<String> listImages = [
  "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1472224371017-08207f84aaae?crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1523217582562-09d0def993a6?crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1577552568192-467a12a7f376?crop&w=1050&q=80"
];

Widget buildVerticalItem(BuildContext context, int index, result) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(8.0),
    width: double.infinity,
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
        Container(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(result['Property']['Images'].elementAt(0),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result['Location'].elementAt(1).toString(),
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(result['Location'].elementAt(0).toString(),
                    style: Theme.of(context).textTheme.caption),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xffffcfa9),
              ),
              child: Text(
                "\$250/mo",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/*
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
*/
