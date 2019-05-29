import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SegmentBar {
  Color backgroundColor;

  SegmentBar({
    @required this.backgroundColor,
  });

  factory SegmentBar.initial() {
    return SegmentBar(
      backgroundColor: Colors.black,
    );
  }
}
