import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DrawerMenu {
  Color backgroundColor;
  Color topBackgroundColor;

  DrawerMenu({
    @required this.backgroundColor,
    @required this.topBackgroundColor,
  });

  factory DrawerMenu.initial() {
    return DrawerMenu(
      backgroundColor: Colors.black,
      topBackgroundColor: Colors.white,
    );
  }
}
