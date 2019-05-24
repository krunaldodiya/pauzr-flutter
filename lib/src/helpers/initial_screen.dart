import 'package:flutter/material.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/tab.dart';
import 'package:pauzr/src/screens/users/edit_profile.dart';

Widget getInitialScreen(User user) {
  if (user != null) {
    if (user.status == 1) {
      return TabPage(showTabIndex: 1);
    }

    return EditProfilePage(shouldPop: false);
  }

  return IntroPage();
}
