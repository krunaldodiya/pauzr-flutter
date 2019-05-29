import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MainScoreboard {
  Color backgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  MainScoreboard({
    @required this.backgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory MainScoreboard.initial() {
    return MainScoreboard(
      backgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
    );
  }
}
