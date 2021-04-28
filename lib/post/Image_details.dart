/*
//import 'package:dropdownfield/dropdownfield.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rantal/View/ui/mapview.dart';
import 'package:rantal/model/propertyModel.dart';
import 'dart:io' as io;
import 'package:provider/provider.dart';
*/

/*class Imagedetails extends StatefulWidget {

  @override
  _ImagedetailsState createState() => _ImagedetailsState();
}*/
/*

class _ImagedetailsState extends State<Imagedetails> {
  
  final _formKey = GlobalKey<FormState>();
 // FirebaseStorage storage = FirebaseStorage.instanceFor();
  var validate = false;
  final Location location = Location();
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  List<String> Images = [];
*/

/* void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        validate = true;
      });
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }*/

//location

/*Future<void> uploadPic(String uid) async {
    String uri;

    //Get the file from the image picker and store it
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    images.first.
    _image = io.File(image.path);
    //Create a reference to the location you want to upload to in firebase
    Reference reference = await storage.ref().child('images/${uid+Dt.millisecondsSinceEpoch.toString()}');
    reference.putFile(_image).whenComplete((){
      reference.getDownloadURL().then((value) {
        Imageurl= value;
        print(Imageurl);
      });
    });
    /*//Upload the file to firebase
    UploadTask uploadTask = (await reference.putFile(_image)) as UploadTask;

    // Waits till the file is uploaded then stores the download url
    //Uri location = await uploadTask.storage.g;

      uploadTask.snapshotEvents.listen((event) {
        double percentage = 100 *(event.bytesTransferred.toDouble()
            / event.totalBytes.toDouble());
        print("THe percentage " + percentage.toString());
      }).onDone(() async{
         uri = await storage.;
        print("The download URL is " + uri);
        print("Download image from here" + uri);
      });*/
  }*/

/* Future<void> uploadImage(
      {String uid, @required List<Asset> assets}) async {
    List<String> uploadUrls = [];
    print(uid);
    DateTime Dt = DateTime.now();

    assets.forEach((element) async{

      var path =await FlutterAbsolutePath.getAbsolutePath(element.identifier);
      File tempFile = File(path);

      Reference reference = FirebaseStorage.instance.ref().child(uid.toString()+'/'+Dt.millisecondsSinceEpoch.toString());
      UploadTask uploadTask = reference.putFile(tempFile);
      TaskSnapshot storageTaskSnapshot;

      // Release the image data

      TaskSnapshot snapshot = await uploadTask.snapshot;
      if (snapshot != null) {
        storageTaskSnapshot = snapshot;
        final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        uploadUrls.add(downloadUrl);
        print(downloadUrl);
        print('Upload success');
      } else {
        print('Error from image repo ${snapshot.toString()}');
        throw ('This file is not an image');
      }
    }
    );
  }*/

/*Future<void> loadAssets(String Uid) async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Rental Image App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    print(resultList.length.toString() + "++++++++++++++++++++++++");
    print(images.length);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }*/

/*  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
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
                        "Image Details",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          color: Colors.grey,
                          child: Center(
                            child: IconButton(
                              onPressed: () async{
                                String uri;
                                DateTime Dt = DateTime.now();
                                print(PropertyModel.id);
                                //Get the file from the image picker and store it
                                var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                                var  _image = io.File(image.path);
                                //Create a reference to the location you want to upload to in firebase
                                Reference reference = await FirebaseStorage.instance.ref().child('${firebaseUser.uid}/${PropertyModel.id}');
                                reference.putFile(_image).whenComplete((){
                                  reference.getDownloadURL().then((value) {
                                    setState(() {
                                      Images.add(value);
                                    });

                                    print(value);

                                  });
                                });
                                PropertyModel.Property['Images']=Image;
                              },
                              icon :Icon(Icons.add_a_photo),
                            ),
                          )
                      ),
                      Container(
                        width: 50,
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: Images.length,
                            itemBuilder: (_,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 80,
                                child: Image(
                                  image: NetworkImage(Images.elementAt(index)),
                                  fit: BoxFit.fill,
                                ),
                              )
                            );
                            }),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 20),
                      child: Text(
                        "Upload Image",
                      ),
                    ),
                  ),
                  // Container()  ama taro image post walo code lakhi nakh je
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
                                          "Location",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Padding(
                                    padding: const EdgeInsets.only(
                                          left: 25.0, bottom: 20.0, right: 25.0),
                                    child: Text("Select your property location"),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, bottom: 20.0,right: 25.0),
                                      child: Container(
                                        child: IconButton(
                                          icon: Icon(Icons.location_on_sharp),
                                          iconSize: 20,
                                          tooltip: "click to select location",

                                          splashColor: Color(0xff162b50),
                                          onPressed:
                                              () {

                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MymapPage(locationData: _locationData,)));
                                              }, //taro map valo code nakh je
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ])),
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
                                          "Enter Full Address",
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
                                      cursorColor: Colors.blue,
                                      maxLength: 250,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Full Address',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                          validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Full Address';
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
                     padding: const EdgeInsets.only(top:40.0,bottom:150.0),
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
                              child: Text("Previous",style: TextStyle(fontSize: 15.0,
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
                              onPressed: ()async {
                                print(PropertyModel.Location);
                                validateAndSave();
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState.validate()) {
                                  print(PropertyModel.Location);
                                  DateTime Dt = DateTime.now();

                                  PropertyModel.Property['Rate'] = 0;
                                  PropertyModel.Property['RateCount']=0;
                                  PropertyModel.Property['Like']=0;
                                  PropertyModel.Property['Varified']=false;
                                  PropertyModel.Owner['Date'] = Dt.millisecondsSinceEpoch;
                                  PropertyModel.Owner['Uid'] =firebaseUser.uid;

                                  await FirebaseFirestore.instance.collection('properties').doc(PropertyModel.id).set(
                                    {
                                      "Owner":PropertyModel.Owner,
                                      "Property":PropertyModel.Property,
                                      "Location":PropertyModel.Location
                                    }
                                  );
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    
                                      SnackBar(content: Text('Processing Data')
                                      )
                                      );
                                }
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>Personaldetails()),);
                              },
                              child: Text("Next",style: TextStyle(fontSize: 15.0,
                            	
                              ),),
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
}*/
