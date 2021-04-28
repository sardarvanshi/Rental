/*
//import 'package:dropdownfield/dropdownfield.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:rantal/config/palette.dart';
import 'package:rantal/model/propertyModel.dart';
import 'Image_details.dart';

class Properties extends StatefulWidget {

  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
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

  String valuechoose;
  String Termchoose;
  List listitem = [
    'Shop',
    'Marriage Farm',
    'Farm House',
    'Only Swiming pool',
    'Sports Ground',
  ];
  List Term = [
    'Month',
    'Year',
    'Day',
  ];

  Map<String, dynamic> formData;
  List<String> state = [
    'Andhra Pradesh',
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal	",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Properties",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Scaffold(
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
                      "Property Details",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Palette.darkBlue,
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
                                          "Property Name",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
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
                                      onChanged: (value) {
                                        PropertyModel.Property['Name'] = value;
                                      },
                                      cursorColor: Colors.blue,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Property Name',
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Colors.white,
                          elevation: 5.0,
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
                                          "Category",
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
                                      child: DropdownButton(
                                    hint: Text(
                                      "Select Your propery type",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    dropdownColor: Colors.white,
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle_sharp,
                                    ),
                                    iconSize: 30,
                                    isExpanded: true,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                    value: valuechoose,
                                    onChanged: (newValue) {
                                      setState(() {
                                        PropertyModel.Property['Category'] = newValue;
                                        valuechoose = newValue;
                                      });
                                    },
                                    items: listitem.map((valueitem) {
                                      return DropdownMenuItem(
                                          value: valueitem,
                                          child: Text(valueitem));
                                    }).toList(),
                                  )),
                                ),
                              ])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Palette.darkBlue,
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
                                          "Price",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
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
                                        PropertyModel.Property['Price']=int.parse(value);
                                      },
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 7,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter your price',
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter price';
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
                                          "Deposite Price",
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
                                        PropertyModel.Property['Deposite']=int.parse(value);
                                      },
                                      cursorColor: Colors.blue,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 7,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Deposite Price',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Drposite Price';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ])),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Colors.white,
                          elevation: 5.0,
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
                                          "Category",
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
                                      child: DropdownButton(
                                        hint: Text(
                                          "Select Your propery type",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        dropdownColor: Colors.white,
                                        icon: Icon(
                                          Icons.arrow_drop_down_circle_sharp,
                                        ),
                                        iconSize: 30,
                                        isExpanded: true,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                        value: Termchoose,
                                        onChanged: (newValue) {
                                          setState(() {
                                            PropertyModel.Property['Term'] = newValue;
                                            Termchoose = newValue;
                                          });
                                        },
                                        items: Term.map((valueitem) {
                                          return DropdownMenuItem(
                                              value: valueitem,
                                              child: Text(valueitem));
                                        }).toList(),
                                      )),
                                ),
                              ])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Material(
                          color: Palette.darkBlue,
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
                                          "Square Feet",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
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
                                        PropertyModel.Property['SquareFeet']=double.parse(value);
                                      },
                                      cursorColor: Colors.white,
                                      maxLength: 7,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText:
                                              'Enter property Square feets',
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Square';
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Colors.white,
                          elevation: 5.0,
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
                                          "State",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, bottom: 20.0, right: 25.0),
                                  child: Container(
                                    child: DropDownField(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),

                                        // value: formData['City'],
                                        required: true,
                                        hintText: 'Choose a State',
                                        hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                        items: state,
                                        strict: false,
                                        setter: (dynamic newValue) {
                                          PropertyModel.Location.add(newValue);
                                        }),
                                    color: Colors.white,
                                  ),
                                ),
                              ])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Palette.darkBlue,
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
                                          "City",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
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
                                        PropertyModel.Location['City']=value;
                                      },
                                      cursorColor: Colors.white,
                                      maxLength: 25,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter City Name',
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                    ),
                                  ),
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
                                          "Landmark",
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
                                        PropertyModel.Location['Landmark']=value;
                                      },
                                      cursorColor: Colors.blue,
                                      maxLength: 25,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Your Landmark',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter LandMark';
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Material(
                          color: Palette.darkBlue,
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
                                          "Pin Code",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
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
                                        PropertyModel.Location['PinCode']=int.parse(value);
                                      },
                                      cursorColor: Colors.white,
                                      maxLength: 25,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter Pincode number',
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter pincode';
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
                                      onChanged: (value){
                                        PropertyModel.Location['FullAddress']=value;
                                      },
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
                                          return 'Please Enter Full Addres';
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
                              "Back",
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
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Imagedetails()),
                                );
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
      ),
    );
  }
}
*/
