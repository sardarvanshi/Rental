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
      child: Column(
        children: [
          Container(
            child: Center(
              child: Icon(Icons.linear_scale_rounded,color:colorlist[0],size: 50,)
            ),
          ),
          Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
