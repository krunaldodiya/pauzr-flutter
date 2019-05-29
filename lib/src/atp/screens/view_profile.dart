import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ViewProfile {
  Color backgroundColor;

  ViewProfile({
    @required this.backgroundColor,
  });

  factory ViewProfile.initial() {
    return ViewProfile(
      backgroundColor: Colors.black,
    );
  }
}
