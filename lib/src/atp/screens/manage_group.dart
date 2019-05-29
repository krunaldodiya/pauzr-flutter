import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ManageGroup {
  Color backgroundColor;
  Color appBackgroundColor;

  ManageGroup({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory ManageGroup.initial() {
    return ManageGroup(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
    );
  }
}
