import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GroupScoreboard {
  Color backgroundColor;

  GroupScoreboard({
    @required this.backgroundColor,
  });

  factory GroupScoreboard.initial() {
    return GroupScoreboard(
      backgroundColor: Colors.black,
    );
  }
}
