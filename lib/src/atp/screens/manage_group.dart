import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ManageGroup {
  Color backgroundColor;

  ManageGroup({
    @required this.backgroundColor,
  });

  factory ManageGroup.initial() {
    return ManageGroup(
      backgroundColor: Colors.black,
    );
  }
}
