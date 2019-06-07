import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MainScoreboard {
  Color backgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;
  Color cardTopBackgroundColor;
  Color cardBottomBackgroundColor;
  Color cardTopColor;
  Color cardBottomColor;

  MainScoreboard({
    @required this.backgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
    @required this.cardTopBackgroundColor,
    @required this.cardBottomBackgroundColor,
    @required this.cardTopColor,
    @required this.cardBottomColor,
  });

  factory MainScoreboard.initial() {
    return MainScoreboard(
      backgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
      cardTopBackgroundColor: Colors.white,
      cardBottomBackgroundColor: Colors.black,
      cardTopColor: Colors.white,
      cardBottomColor: Colors.black,
    );
  }
}
