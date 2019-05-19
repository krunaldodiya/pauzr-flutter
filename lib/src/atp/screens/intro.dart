import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Intro {
  var backgroundColor;

  Intro({
    @required this.backgroundColor,
  });

  factory Intro.initial() {
    return Intro(
      backgroundColor: Colors.black,
    );
  }
}
