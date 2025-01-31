import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Tabs {
  Color backgroundColor;
  Color appBarBackgroundColor;

  Tabs({
    @required this.backgroundColor,
    @required this.appBarBackgroundColor,
  });

  factory Tabs.initial() {
    return Tabs(
      backgroundColor: Colors.black,
      appBarBackgroundColor: Colors.black,
    );
  }
}
