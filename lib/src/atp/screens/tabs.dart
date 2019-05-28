import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Tabs {
  Color backgroundColor;
  Color appBarBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  Tabs({
    @required this.backgroundColor,
    @required this.appBarBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory Tabs.initial() {
    return Tabs(
      backgroundColor: Colors.black,
      appBarBackgroundColor: Color(0xFF000000),
      navigationColor: Color(0xFF000000),
      navigationButtonBackgroundColor: Color(0xFF000000),
    );
  }
}
