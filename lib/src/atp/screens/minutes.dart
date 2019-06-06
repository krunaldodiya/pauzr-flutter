import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Minutes {
  Color backgroundColor;
  Color appBackgroundColor;
  Color cardTopBackgroundColor;
  Color cardBottomBackgroundColor;

  Minutes({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
    @required this.cardTopBackgroundColor,
    @required this.cardBottomBackgroundColor,
  });

  factory Minutes.initial() {
    return Minutes(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
      cardTopBackgroundColor: Colors.black,
      cardBottomBackgroundColor: Colors.black,
    );
  }
}
