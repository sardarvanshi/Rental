import 'package:flutter/material.dart';

class genre extends StatelessWidget {
  var result;

  genre(this.result);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 10, right: 10),
        children: <Widget>[
          genre_moods(
            'https://i.pinimg.com/originals/92/d3/e2/92d3e202bee3df35b5a65278158677c1.jpg',
            // Photo from https://unsplash.com/photos/8Os-QSo01zY
            result,
          ),
        ],
      ),
    );
  }

  Widget genre_moods(
    String imageurl,
    String music,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Image.network(
                imageurl,
                height: 120,
                width: 220,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 60,
                left: 20,
                child: Text(
                  music,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ],
    );
  }
}

Widget genre_moods(
  String imageurl,
  String music,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Image.network(
              imageurl,
              height: 120,
              width: 220,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 60,
              left: 20,
              child: Text(
                music,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    ],
  );
}
