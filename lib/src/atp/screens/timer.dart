import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Timer {
  Color backgroundColor;
  Color quoteBackgroundColor;

  Timer({
    @required this.backgroundColor,
    @required this.quoteBackgroundColor,
  });

  factory Timer.initial() {
    return Timer(
      backgroundColor: Colors.black,
      quoteBackgroundColor: Colors.black,
    );
  }
}
