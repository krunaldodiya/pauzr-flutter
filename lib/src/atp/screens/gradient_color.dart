import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GradientColor {
  Color color1;
  Color color2;

  GradientColor({
    @required this.color1,
    @required this.color2,
  });

  factory GradientColor.initial() {
    return GradientColor(
      color1: Colors.black,
      color2: Colors.white,
    );
  }
}
