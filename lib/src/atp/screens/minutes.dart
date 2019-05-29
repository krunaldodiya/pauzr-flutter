import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Minutes {
  Color backgroundColor;

  Minutes({
    @required this.backgroundColor,
  });

  factory Minutes.initial() {
    return Minutes(
      backgroundColor: Colors.black,
    );
  }
}
