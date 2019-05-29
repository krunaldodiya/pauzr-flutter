import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GroupDetail {
  Color backgroundColor;
  Color appBackgroundColor;

  GroupDetail({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory GroupDetail.initial() {
    return GroupDetail(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
    );
  }
}
