import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

//COLORS

const Color kGreen = Color(0xff065f2b);

//TEXT STYLES
TextStyle kDetailsStyle = GoogleFonts.merriweather(
    fontSize: 20, fontWeight: FontWeight.bold, color: kGreen);
TextStyle kCharacterScreenTextStyle = GoogleFonts.merriweather(
    color: kGreen, fontSize: 10.sp, fontWeight: FontWeight.bold);

//SHADOW
const kShadow = [
  BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
];

//URL
const String kUrl =
    'https://breakingbadapi.com/api/characters?limit=10&offset=';
