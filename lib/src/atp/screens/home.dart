import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Home {
  Color backgroundColor;

  Home({
    @required this.backgroundColor,
  });

  factory Home.initial() {
    return Home(
      backgroundColor: Colors.black,
    );
  }
}
