import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Timer {
  Color backgroundColor;
  Color quoteBackgroundColor;
  Color cardTopBackgroundColor;
  Color cardBottomBackgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  Timer({
    @required this.backgroundColor,
    @required this.quoteBackgroundColor,
    @required this.cardTopBackgroundColor,
    @required this.cardBottomBackgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory Timer.initial() {
    return Timer(
      backgroundColor: Colors.black,
      quoteBackgroundColor: Colors.black,
      cardTopBackgroundColor: Colors.black,
      cardBottomBackgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
    );
  }
}
