import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class UserNotification {
  Color backgroundColor;
  Color appBackgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;

  UserNotification({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
  });

  factory UserNotification.initial() {
    return UserNotification(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
    );
  }
}
