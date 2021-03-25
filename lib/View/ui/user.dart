import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rantal/bloc/userinfo_bloc.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';

class Userinfo extends StatefulWidget {
  @override
  _UserinfoState createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  userinfo_bloc ub =   userinfo_bloc ();
dataprovider dp =dataprovider();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // ub.fetdata();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<userinfo>(
          stream: dp.getUserList(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return
                  Text(snapshot.data.favorites.pid.toString());
            }
            return CircularProgressIndicator(
             backgroundColor: Color(0xff1e2140),
            );
          },
        ),
      ),
    );
  }
}
