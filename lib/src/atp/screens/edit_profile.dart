import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class EditProfile {
  Color backgroundColor;

  EditProfile({
    @required this.backgroundColor,
  });

  factory EditProfile.initial() {
    return EditProfile(
      backgroundColor: Colors.black,
    );
  }
}
