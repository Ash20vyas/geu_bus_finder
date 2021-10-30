import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double h1 = 28;
double h2 = 24;
double h3 = 19;
double h4 = 17;
double h5 = 15;
double h6 = 13;

var logoRed  = Color(0xffDFA3A3);
var black = Color(0xff343434);
var textBoxColor  = Color(0xffECEAEA);
var boxRed = Color(0xffF5C5C5);
var boxRedText = Color(0xffD68585);
var subTitleColor = Color(0xffDACCCC);


TextStyle poppins(Color col, [double? x, FontWeight? weight]) {
  return GoogleFonts.poppins(textStyle: TextStyle(height: 1, letterSpacing: -0.5, fontWeight: weight ?? FontWeight.bold, color: col, fontSize: x ?? h5));
}

TextStyle montserrat(Color col, [double? x, FontWeight? weight]) {
  return GoogleFonts.montserrat(textStyle: TextStyle(height: 1, fontWeight: weight ?? FontWeight.bold, color: col, fontSize: x ?? h5));
}
