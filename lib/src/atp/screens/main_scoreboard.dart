import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MainScoreboard {
  Color backgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;
  Color cardBackground;

  MainScoreboard({
    @required this.backgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
    @required this.cardBackground,
  });

  factory MainScoreboard.initial() {
    return MainScoreboard(
      backgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
      cardBackground: Colors.black,
    );
  }
}
