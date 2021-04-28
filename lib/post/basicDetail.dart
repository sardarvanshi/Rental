import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rantal/View/ui/ProprtyMap.dart';
import 'package:rantal/View/ui/mapview.dart';
import 'package:location/location.dart';
import 'package:rantal/model/propertyModel.dart';
import 'package:rantal/post/propertyDetail.dart';

class basicDetail extends StatefulWidget {
  @override
  _basicDetailState createState() => _basicDetailState();
}

class _basicDetailState extends State<basicDetail> {
  final location = Location();
  final _formKey = GlobalKey<FormState>();
  final _cityKey = GlobalKey<FormFieldState>();
  final _locality = GlobalKey<FormFieldState>();
  final _Socity = GlobalKey<FormFieldState>();
  final _hno = GlobalKey<FormFieldState>();
  bool _serviceEnabled;
  String valuechoose;
  List<String> Images = [];
  List<String> listitem = [
    'Shop',
    'Marriage Farm',
    'Farm House',
    'Only Swiming pool',
    'Sports Ground',
  ];

  void getcurrentLocation() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    Position currentposition = await Geolocator().getCurrentPosition();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      backgroundColor: Color(0xfff4f3f3),
      appBar: AppBar(
        title: Text("Basic Information"),
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
                  SizedBox(
                    height: 20,
                  ),
                  //TYPE
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("YOUR PROPERTY TYPE")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownField(
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 15.0),

                              // value: formData['City'],
                              required: true,
                              hintText: 'Select property Type',
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              items: listitem,
                              strict: false,
                              setter: (dynamic newValue) {
                                PropertyModel.Property['Category'] = newValue;
                              }),
                        )),
                  ),

                  //PHOTOS
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("ADD YOUR PROPERTY PHOTOS"),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Center(
                            child: IconButton(
                              iconSize: 50,
                              onPressed: () async {
                                String uri;
                                DateTime Dt = DateTime.now();
                                //print(PropertyModel.id);
                                //Get the file from the image picker and store it
                                var image = await ImagePicker.platform
                                    .pickImage(source: ImageSource.gallery);
                                var _image = File(image.path);
                                //Create a reference to the location you want to upload to in firebase
                                Reference reference =
                                    await FirebaseStorage.instance.ref().child(
                                        '${firebaseUser.uid}/${PropertyModel.id}');
                                reference.putFile(_image).whenComplete(() {
                                  reference.getDownloadURL().then((value) {
                                    setState(() {
                                      Images.add(value);
                                    });

                                    print(value);
                                  });
                                });
                                PropertyModel.Property['Images'] = Images;
                              },
                              icon: Icon(Icons.add_a_photo),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 80,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: Images.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 80,
                                        child: Image(
                                          image: NetworkImage(
                                              Images.elementAt(index)),
                                          fit: BoxFit.fill,
                                        ),
                                      ));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("YOUR PROPERTY ADDRESS"),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            key: _cityKey,
                            strutStyle: StrutStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {},
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'City',
                                hintStyle: TextStyle(color: Colors.black)),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter city';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: _locality,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {},
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Locality/Area',
                                hintStyle: TextStyle(color: Colors.black)),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Locality';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: _Socity,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {},
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                                labelText: 'Society or Project ',
                                border: UnderlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.black)),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Society or Project";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: _hno,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {
                              PropertyModel.Property['Hno'] = value ?? "";
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Home,shop,Farm,office no.";
                              }
                              return null;
                            },
                            cursorColor: Colors.blue,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'No/Street Name',
                                hintStyle: TextStyle(color: Colors.black)),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    color: Color(0xfff4f3f3),
                                    height: 100,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.amber),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MymapPage()));
                                            },
                                            icon: Icon(Icons.place),
                                            label: Text(
                                                "Tap to mark your property exactly")),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      // if(_formKey.currentState.validate()) {
                      PropertyModel.Location.add(_cityKey.currentState.value);
                      PropertyModel.Location.add(_Socity.currentState.value);
                      PropertyModel.Location.add(_hno.currentState.value ?? "");
                      PropertyModel.Location.add(_locality.currentState.value);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PropertyDetail()));
                      // }
                    },
                    child: Text("Next")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
