import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);

const kHeadingTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Color(0xFF00BABA),
);

const kSelectedButtonTextStyle =
    TextStyle(fontFamily: 'Source Sans Pro', fontSize: 20, color: Colors.white);
const kButtonTextStyle =
    TextStyle(fontFamily: 'Source Sans Pro', fontSize: 20, color: Colors.white);

var kSelectedButtonDecoration = BoxDecoration(
    color: Color(0xFF00BABA),
    border: Border.all(color: Color(0xFFD2D2D2)),
    borderRadius: BorderRadius.circular(5));
var kButtonDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Color(0xFFD2D2D2)),
    borderRadius: BorderRadius.circular(5));
