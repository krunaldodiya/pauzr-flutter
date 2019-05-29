import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Minutes {
  Color backgroundColor;
  Color appBackgroundColor;

  Minutes({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory Minutes.initial() {
    return Minutes(
      backgroundColor: Colors.white,
      appBackgroundColor: Colors.black,
    );
  }
}
