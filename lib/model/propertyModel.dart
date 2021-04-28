import 'package:flutter/material.dart';

class PropertyModel {
  static String id = DateTime.now().millisecondsSinceEpoch.toString();
  static Map<String, dynamic> Property = {};

  //static Map<String,dynamic> Owner = {};
  static List<String> Location = [];

  List<String> Images = [];
  String Name;
  String Category;
  int Price;
  int Deposite;
  double SquareFeet;
  String State;
  String city;
  String Landmark;
  int PinCode;
  String FullAddress;

  // Map<String,dynamic> Location;
  int ContactNo;
  int Rate = 0;
  int RateCount = 0;
  DateTime Dt;
  bool Verified = false;
  int Like;
  String Term;
}
