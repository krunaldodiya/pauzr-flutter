import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Timer {
  Color backgroundColor;
  Color quoteBackgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  Timer({
    @required this.backgroundColor,
    @required this.quoteBackgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory Timer.initial() {
    return Timer(
      backgroundColor: Colors.black,
      quoteBackgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
    );
  }
}
