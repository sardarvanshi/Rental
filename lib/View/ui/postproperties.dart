
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import '../util/utisUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Favorites.dart';

class PostProperties extends StatefulWidget {
  @override
  _PostPropertiesState createState() => _PostPropertiesState();
}

class _PostPropertiesState extends State<PostProperties> {

  FirebaseFirestore Myfirebasefirestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instanceFor();
  Map data ;
  io.File _image;
  String Imageurl;

  var name;
  var image;
  var price;
  var rate;
  var contact;
  var about;
  var city;
 var term;

 DateTime dt = new DateTime.now();


 Future<void> postData()async {
   var id= "uid005" + dt.toString();
   await Myfirebasefirestore.collection('properties').doc(id).set(
     {
       "name" :name,
       "city":city,
       "cno":contact,
       "image":Imageurl,
       "rprice":price,
       "term":term,
       "about":about,
     }
   );
 }

  Future<void> uploadPic() async {
    String uri;
    DateTime Dt = DateTime.now();
    //Get the file from the image picker and store it
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    _image = io.File(image.path);
    //Create a reference to the location you want to upload to in firebase
    Reference reference = await storage.ref().child('images/${Dt.millisecondsSinceEpoch}');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            children: [
              Text("Name of properties"),
              TextField(
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true
                ),
                autocorrect: true,
                onChanged: (value){name=value;},
                decoration: InputDecoration(
                  hintText: "enter",
                 // errorText: "error",
                ),
              ),
            Divider(),
              Text("Price"),
              TextField(
                keyboardType: TextInputType.number,
                toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true
                ),
                autocorrect: true,
                onChanged: (value){price=value;},
                decoration: InputDecoration(
                  hintText: "enter price",
                  // errorText: "error",
                ),
              ),


              MaterialButton(
                color: Colors.blueGrey,
                onPressed: () {
                  uploadPic();
                  print(Imageurl);
                },
              child: Text("image"),),


                Divider(),
                Text("rate"),
                TextField(
                keyboardType: TextInputType.number,
                toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: true
                ),
                autocorrect: true,
                onChanged: (value){rate=value;},
                decoration: InputDecoration(
                hintText: "enter rate",
                // errorText: "error",
                ),
                ),

                Text("About"),
                TextField(
                toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: true
                ),

                onChanged: (value){about=value;},
                decoration: InputDecoration(
                  hintText: "enter about",
                  // errorText: "error",
                ),
              ),

              Text("city"),
              TextField(
                toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true
                ),
                autocorrect: true,
                onChanged: (value){city=value;},
                decoration: InputDecoration(
                  hintText: "enter city",
                  // errorText: "error",
                ),
              )
              ,Text("contact"),
              TextField(
                keyboardType: TextInputType.phone,
                toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true
                ),
                autocorrect: true,
                onChanged: (value){contact=value;},
                decoration: InputDecoration(
                  hintText: "enter cno",
                  // errorText: "error",
                ),
              ),
             
              
              Text("Term"),
              TextField(
                toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true
                ),
                autocorrect: true,
                onChanged: (value){term=value;},
                decoration: InputDecoration(
                  hintText: "enter term",
                  // errorText: "error",
                ),
              ),

              MaterialButton(onPressed: ()=>postData(),color: Colors.green,child: Text("Post Data"),),

            ],
          ),
        ),
      ),
    );
  }
}



class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {


  FirebaseFirestore Myfirebasefirestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instanceFor();
  Map data ;
  io.File _image;
  String Imageurl;

  var type;
  var name;
  var image;
  var price;
  var rate;
  var contact;
  var about;
  var city;
  var term;

  Future<void> postData()async {
    await Myfirebasefirestore.collection('properties').doc("uid005").set(
        {
          "name" :name,
          "city":city,
          "cno":contact,
          "image":Imageurl,
          "rprice":price,
          "term":term,
          "type":type,
          "about":about,
        }
    );
  }






  final Location location = Location();
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    // DM.Ld = _locationData;
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
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
      image = resultList;
      images = resultList;
      _error = error;
    });
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  List<String> droplist = ['a', 'a', 'b'];


  Widget steps() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      //  height: MediaQuery.of(context).size.height/2,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Name Of Properties",
                  style: PostPropertylebl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) => name = value,
                  maxLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xfff6f6fe),
                      //fillColor: Color(0xffE1F1F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Name Of Properties'),
                ),
              ),
              Text(
                "Type of property",
                style: PostPropertylebl,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    focusColor: Colors.lightBlueAccent,
                    elevation: 15,
                    isExpanded: true,
                    isDense: true,
                    hint: Text("Select Property type"),
                    dropdownColor: Color(0xffc2c4ce),
                    items: droplist.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) =>  type= value,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "About",
                  style: PostPropertylebl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) =>about,
                  maxLines: 4,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xfff6f6fe),
                      //fillColor: Color(0xffE1F1F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'About'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Price",
                  style: PostPropertylebl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) => price = value,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xfff6f6fe),
                      //fillColor: Color(0xffE1F1F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Enter Price'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Stepper Demo'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(primaryColor: Colors.blueGrey),
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                        title: new Text('Property Details '),
                        content: Column(
                          children: <Widget>[
                            steps(),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled),
                    Step(
                      title: new Text('Address'),
                      content: Container(
                        child: Column(
                          children: <Widget>[
                            ElevatedButton(
                              child: Text("Pick images"),
                              onPressed: loadAssets,
                            ),
                            ElevatedButton(
                              child: Text("Location"),
                              onPressed: () {
                                getLocation();

                                print(_locationData.longitude.toString() +
                                    "---" +
                                    _locationData.latitude.toString());
                              },
                            ),
                            //buildGridView()
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Mobile Number'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            onChanged: (value) => contact = int.parse(value),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xfff6f6fe),
                                //fillColor: Color(0xffE1F1F6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'Mobile Number'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "City",
                              style: PostPropertylebl,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) => city = value,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff6f6fe),
                                  //fillColor: Color(0xffE1F1F6),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Enter City'),
                            ),
                          ),
                        ],
                      ),
                      //isActive:_currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2
        ? setState(() => _currentStep += 1)
        : Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FavoritesPage()));
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
