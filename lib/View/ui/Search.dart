import 'package:flutter/material.dart';
import 'package:rantal/View/util/utisUi.dart';



class searchPage extends StatefulWidget {
  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorlist[2],
        borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),topLeft: Radius.circular(25.0)),
      ),
      child: Center(
        child: Text(
          "Hello! I'm a bottom sheet :D",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
