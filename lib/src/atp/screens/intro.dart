import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Intro {
  var backgroundColor;
  var colorActiveDot;
  var colorDot;
  var doneBtnColor;
  var skipBtnColor;
  var prevBtnColor;

  Intro({
    @required this.backgroundColor,
    @required this.colorActiveDot,
    @required this.colorDot,
    @required this.doneBtnColor,
    @required this.skipBtnColor,
    @required this.prevBtnColor,
  });

  factory Intro.initial() {
    return Intro(
      backgroundColor: Colors.black,
      colorActiveDot: Colors.black,
      colorDot: Colors.black,
      doneBtnColor: Colors.black,
      skipBtnColor: Colors.black,
      prevBtnColor: Colors.black,
    );
  }
}
