import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GroupScoreboard {
  Color backgroundColor;
  Color appBackgroundColor;

  GroupScoreboard({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory GroupScoreboard.initial() {
    return GroupScoreboard(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
    );
  }
}
