import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:rantal/View/ui/Home.dart';
import 'package:rantal/model/propertyModel.dart';

class PropertyDetail extends StatefulWidget {
  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  final _formKey = GlobalKey<FormState>();

  List<String> Furnishing = [
    'Unfurnished',
    'Semi-furnished',
    'Fully-furnished'
  ];

  List _myActivities;
  List<String> Term = [
    'Month',
    'Year',
    'Day',
  ];
  String Termchoose;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      backgroundColor: Color(0xfff4f3f3),
      appBar: AppBar(
        title: Text("Property Detail"),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("PRICE"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['Price'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Asking Price',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter price';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['Deposite'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Deposite',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Deposite';
                                }
                                return null;
                              },
                            ),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropDownField(
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 15.0),

                                    // value: formData['City'],
                                    required: true,
                                    hintText: 'Select property Term',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                    items: Term,
                                    strict: false,
                                    setter: (dynamic newValue) {
                                      PropertyModel.Property['Term'] = newValue;
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("PROPERTY DETAILS"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['Squarefeet'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Square Feet',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter S.feet';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['Bedroom'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Bedroom(s)',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Bedroom';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['Kitchen'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Bathroom(S)',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Kitchen';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['Bathroom'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Bathroom(S)',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Bathroom(s)';
                                }
                                return null;
                              },
                            ),
                            DropDownField(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 15.0),

                                // value: formData['City'],
                                required: true,
                                hintText: 'Furnishing',
                                hintStyle: TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                                items: Furnishing,
                                strict: false,
                                setter: (dynamic newValue) {
                                  PropertyModel.Property['Furnishing'] =
                                      newValue;
                                }),
                            MultiSelectFormField(
                              autovalidate: false,
                              chipBackGroundColor: Colors.blue,
                              chipLabelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              dialogTextStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              checkBoxActiveColor: Colors.blue,
                              checkBoxCheckColor: Colors.white,
                              dialogShapeBorder: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              title: Text(
                                "Amenities",
                                style: TextStyle(fontSize: 16),
                              ),
                              validator: (value) {
                                if (value == null || value.length == 0) {
                                  return 'Please select one or more options';
                                }
                                return null;
                              },
                              dataSource: [
                                {
                                  "display": "Air condition",
                                  "value": "Air condition",
                                },
                                {
                                  "display": "Piped gas",
                                  "value": "Piped gas",
                                },
                                {
                                  "display": "Internet/wifi",
                                  "value": "Internet/wifi",
                                },
                                {
                                  "display": "Park",
                                  "value": "Park",
                                },
                                {
                                  "display": "Fitness Center/Gym",
                                  "value": "Fitness Center/Gym",
                                },
                                {
                                  "display": "Swimming pool",
                                  "value": "Swimming pool",
                                },
                                {
                                  "display": "Visitor Parking",
                                  "value": "Visitor Parking",
                                },
                                {
                                  "display": "Security personal",
                                  "value": "Security personal",
                                }
                              ],
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',
                              hintWidget: Text('Please choose one or more'),
                              initialValue: _myActivities,
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myActivities = value;
                                });
                                print(_myActivities);
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                PropertyModel.Property['About'] = value;
                              },
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'About',
                                  hintStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Something about property';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(PropertyModel.Location);
                        DateTime Dt = DateTime.now();
                        PropertyModel.Property['Aminities'] = _myActivities;
                        PropertyModel.Property['Rate'] = 0;
                        PropertyModel.Property['RateCount'] = 0;
                        PropertyModel.Property['Like'] = 0;
                        PropertyModel.Property['Varified'] = false;
                        PropertyModel.Property['Date'] =
                            Dt.millisecondsSinceEpoch;
                        PropertyModel.Property['Uid'] = firebaseUser.uid;

                        await FirebaseFirestore.instance
                            .collection('properties')
                            .doc(PropertyModel.id)
                            .set({
                          "Property": PropertyModel.Property,
                          "Location": PropertyModel.Location
                        });
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    },
                    child: Text("Done")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
