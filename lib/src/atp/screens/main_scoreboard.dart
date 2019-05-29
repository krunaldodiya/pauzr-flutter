import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MainScoreboard {
  Color backgroundColor;

  MainScoreboard({
    @required this.backgroundColor,
  });

  factory MainScoreboard.initial() {
    return MainScoreboard(
      backgroundColor: Colors.black,
    );
  }
}
