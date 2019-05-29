import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Stop {
  Color backgroundColor;
  Color handBackgroundColor;
  Color waterColor;
  Color strokeCircleColor;

  Stop({
    @required this.backgroundColor,
    @required this.handBackgroundColor,
    @required this.waterColor,
    @required this.strokeCircleColor,
  });

  factory Stop.initial() {
    return Stop(
      backgroundColor: Colors.black,
      handBackgroundColor: Colors.black,
      waterColor: Colors.black,
      strokeCircleColor: Colors.black,
    );
  }
}
