import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rantal/post/basicDetail.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Lottie.asset('assets/lotti/postproperty.json',
                height: 300, width: 300),
            Text(
              "Post Your Property ",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1e2140)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => basicDetail()));
              },
              child: Text(
                "Start",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
