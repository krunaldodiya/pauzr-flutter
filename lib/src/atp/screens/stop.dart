import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Stop {
  Color backgroundColor;

  Stop({
    @required this.backgroundColor,
  });

  factory Stop.initial() {
    return Stop(
      backgroundColor: Colors.black,
    );
  }
}
