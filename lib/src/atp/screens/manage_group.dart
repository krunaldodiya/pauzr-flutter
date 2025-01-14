import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ManageGroup {
  Color backgroundColor;
  Color appBackgroundColor;
  Color cursorColor;

  ManageGroup({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
    @required this.cursorColor,
  });

  factory ManageGroup.initial() {
    return ManageGroup(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
      cursorColor: Colors.black,
    );
  }
}
