import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Levels {
  Color backgroundColor;

  Levels({
    @required this.backgroundColor,
  });

  factory Levels.initial() {
    return Levels(
      backgroundColor: Colors.black,
    );
  }
}
