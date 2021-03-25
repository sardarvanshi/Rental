import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PropertyDetail extends StatefulWidget {
  var result;

  PropertyDetail(this.result);

  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Card(
                child: Stack(
                  children: [
                    Image.network(
                      widget.result['image'],
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color(0xff1e2140),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //property price/term(month/year/day)
                  Container(
                    child: Text(
                      widget.result['rprice'] + "Rs / " + widget.result['term'],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xff1e2140),
                      ),
                    ),
                  ),
                  //info like squre fut, bath ,beds
                  Text("3 Beds, 2 Baths"),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: 80,
                            width: 80,
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.location_on_outlined),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Map View"),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: 80,
                            width: 80,
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.location_on_outlined),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Map View"),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: 80,
                            width: 80,
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.location_on_outlined),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Map View"),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //about
                  Text(
                    "About",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1e2140),
                    ),
                  ),
                  Text(widget.result['about']),
                  Text(
                    "About",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1e2140),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          height: 60,
                          child: ElevatedButton(
                            child: Text(
                              "Call",
                              style: TextStyle(
                                color: Color(0xff1e2140),
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
                              color: Color(0xff1e2140),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: ElevatedButton(
                              child: Text(
                                "Email",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
