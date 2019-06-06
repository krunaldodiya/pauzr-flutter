import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Points {
  Color backgroundColor;
  Color appBackgroundColor;
  Color cardTopBackgroundColor;
  Color cardBottomBackgroundColor;

  Points({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
    @required this.cardTopBackgroundColor,
    @required this.cardBottomBackgroundColor,
  });

  factory Points.initial() {
    return Points(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
      cardTopBackgroundColor: Colors.black,
      cardBottomBackgroundColor: Colors.black,
    );
  }
}
