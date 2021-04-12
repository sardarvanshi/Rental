import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle PostPropertylebl = TextStyle(
  fontWeight: FontWeight.w800,
  color: Color(0xffc2c4ce),
  fontFamily: "Times of Romen",
);

//propertydetail
TextStyle Propertyname = GoogleFonts.robotoSlab(
  fontWeight: FontWeight.bold,
  fontSize: 25,
);

TextStyle term = GoogleFonts.robotoSlab(
  //color: Colors.white,
  fontSize: 15,
);
TextStyle about = GoogleFonts.robotoSlab(
  color: Colors.grey,
  fontSize: 15,
);

//color
List<Color> colorlist = [
  Color(0xff3134c3),
  Color(0xff465ee9),
  Color(0xff9094b0),
  Color(0xfff6f6fe),
  Color(0xff7f86de),
  Color(0xff090909),
  Color(0xffc2c4ce),
  Color(0xff3d3f4c),
];
const AppbarIconColor = Color(0xff162b48);
//const AppbarIconColor = Color(0xff3134c3);
const AppbarTitleStyle = TextStyle(
    color: AppbarIconColor,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic);
