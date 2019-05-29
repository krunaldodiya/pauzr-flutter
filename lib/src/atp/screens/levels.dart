import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Levels {
  Color backgroundColor;
  Color appBackgroundColor;

  Levels({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory Levels.initial() {
    return Levels(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
    );
  }
}
