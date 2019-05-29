import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Points {
  Color backgroundColor;

  Points({
    @required this.backgroundColor,
  });

  factory Points.initial() {
    return Points(
      backgroundColor: Colors.black,
    );
  }
}
