import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DisconnectedPage extends StatefulWidget {
  @override
  _DisconnectedPageState createState() => _DisconnectedPageState();
}

class _DisconnectedPageState extends State<DisconnectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Container(

         child: ListView(
           children: [
             Lottie.asset('assets/lotti/disconnect.json',
             height: 300,
             width: 300),
             Text("You Are Looking Offline",style: TextStyle(color: Color(0xff1e2140)),),
             Text("Check Your Device Connection"),
           ],
         ),
       ),
     ),
    );
  }
}
