import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GroupDetail {
  Color backgroundColor;

  GroupDetail({
    @required this.backgroundColor,
  });

  factory GroupDetail.initial() {
    return GroupDetail(
      backgroundColor: Colors.black,
    );
  }
}
