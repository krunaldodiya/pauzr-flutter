import 'package:flutter/material.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/tabs.dart';
import 'package:pauzr/src/screens/users/edit_profile.dart';

Widget getInitialScreen(User user) {
  if (user != null) {
    if (user.status == 1) {
      return TabsPage();
    }

    return EditProfilePage(shouldPop: false);
  }

  return IntroPage();
}
