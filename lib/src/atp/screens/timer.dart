import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Timer {
  Color backgroundColor;
  Color quoteBackgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;
  Color cardTopBackgroundColor;
  Color cardBottomBackgroundColor;
  Color cardTopColor;
  Color cardBottomColor;

  Timer({
    @required this.backgroundColor,
    @required this.quoteBackgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
    @required this.cardTopBackgroundColor,
    @required this.cardBottomBackgroundColor,
    @required this.cardTopColor,
    @required this.cardBottomColor,
  });

  factory Timer.initial() {
    return Timer(
      backgroundColor: Colors.black,
      quoteBackgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
      cardTopBackgroundColor: Colors.black,
      cardBottomBackgroundColor: Colors.black,
      cardTopColor: Colors.white,
      cardBottomColor: Colors.black,
    );
  }
}
