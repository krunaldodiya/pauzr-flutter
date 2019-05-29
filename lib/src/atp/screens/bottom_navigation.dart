import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BottomNavigation {
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  BottomNavigation({
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory BottomNavigation.initial() {
    return BottomNavigation(
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.white,
    );
  }
}
