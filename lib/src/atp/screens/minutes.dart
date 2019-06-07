import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Minutes {
  Color backgroundColor;
  Color appBackgroundColor;
  Color cardTopBackgroundColor;
  Color cardBottomBackgroundColor;
  Color cardTopColor;
  Color cardBottomColor;

  Minutes({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
    @required this.cardTopBackgroundColor,
    @required this.cardBottomBackgroundColor,
    @required this.cardTopColor,
    @required this.cardBottomColor,
  });

  factory Minutes.initial() {
    return Minutes(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
      cardTopBackgroundColor: Colors.black,
      cardBottomBackgroundColor: Colors.black,
      cardTopColor: Colors.white,
      cardBottomColor: Colors.black,
    );
  }
}
