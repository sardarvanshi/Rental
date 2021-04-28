/*
import 'package:rantal/model/propertyModel.dart';
import 'package:rantal/post/THEMES.dart';
import 'package:flutter/material.dart';

class Personaldetails extends StatefulWidget {
  @override
  _PersonaldetailsState createState() => _PersonaldetailsState();
}

class _PersonaldetailsState extends State<Personaldetails> {
  final _formKey = GlobalKey<FormState>();
  var validate = false;
  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        validate = true;
      });
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white54,
            child: Form(
              key: _formKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35.0, top: 15),
                      child: Text(
                        "Personal details",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Colors.white,
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Colors.black,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      width: 200.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, top: 20),
                                        child: Text(
                                          "Contact Number",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, bottom: 20.0, right: 25.0),
                                  child: Container(
                                    child: TextFormField(
                                      onChanged: (value){
                                        PropertyModel.Owner['ContactNo'] = int.parse(value);
                                      },
                                      keyboardType: TextInputType.phone,
                                      cursorColor: Colors.blue,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Contact Number',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 150.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 170.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.white,
                            elevation: 10.0,
                            shape: StadiumBorder(),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Previous",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 170.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.white,
                            elevation: 10.0,
                            shape: StadiumBorder(),
                            onPressed: () {
                              validateAndSave();
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {
                                 
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  
                                    SnackBar(content: Text('Processing Data')
                                    )
                                    );
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Properties()),);
                              }
                             
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
*/
