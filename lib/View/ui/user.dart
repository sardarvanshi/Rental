import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rantal/bloc/userinfo_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';

class Userinfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userinfo>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child:
                  Column(
                    children: [
                      Text(user.name??"hello"),
                      Text(user.email),
                      Text(user.favorites.elementAt(0)),
                    ],
                  ),
      ),
    );
  }
}
