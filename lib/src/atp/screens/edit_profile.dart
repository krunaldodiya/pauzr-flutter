import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class EditProfile {
  Color backgroundColor;
  Color cursorColor;

  EditProfile({
    @required this.backgroundColor,
    @required this.cursorColor,
  });

  factory EditProfile.initial() {
    return EditProfile(
      backgroundColor: Colors.black,
      cursorColor: Colors.black,
    );
  }
}
