import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Home {
  Color backgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  Home({
    @required this.backgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory Home.initial() {
    return Home(
      backgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
    );
  }
}
