import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AddGroupParticipants {
  Color backgroundColor;
  Color appBackgroundColor;

  AddGroupParticipants({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
  });

  factory AddGroupParticipants.initial() {
    return AddGroupParticipants(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
    );
  }
}
