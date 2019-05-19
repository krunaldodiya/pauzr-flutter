import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Timer {
  var backgroundColor;

  Timer({
    @required this.backgroundColor,
  });

  factory Timer.initial() {
    return Timer(
      backgroundColor: Colors.black87,
    );
  }
}
