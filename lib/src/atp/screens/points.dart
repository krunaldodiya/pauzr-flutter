import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Points {
  Color backgroundColor;
  Color appBackgroundColor;

  Points({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory Points.initial() {
    return Points(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
    );
  }
}
