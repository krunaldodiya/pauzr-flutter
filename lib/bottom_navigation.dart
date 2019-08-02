import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/helpers/tabs.dart';
import 'package:pauzr/src/providers/user.dart';

import 'src/atp/default.dart';

Container getNavigationBar(UserBloc userBloc, DefaultTheme theme) {
  var data = getTabsTheme(userBloc.tabIndex, theme);

  var items = [
    Icon(
      Ionicons.ios_notifications,
      color: Colors.white,
      size: 25.0,
    ),
    Icon(
      Ionicons.ios_people,
      color: Colors.white,
      size: 25.0,
    ),
    Icon(
      Ionicons.ios_pause,
      color: Colors.white,
      size: 25.0,
    ),
    Icon(
      Ionicons.ios_stats,
      color: Colors.white,
      size: 25.0,
    ),
    Icon(
      MaterialCommunityIcons.shopping,
      color: Colors.white,
      size: 25.0,
    ),
  ];

  return Container(
    color: Colors.transparent,
    child: CurvedNavigationBar(
      height: 55.0,
      index: userBloc.tabIndex,
      color: data.navigationColor,
      backgroundColor: data.navigationBackgroundColor,
      buttonBackgroundColor: data.navigationButtonBackgroundColor,
      animationCurve: Curves.easeOutCubic,
      animationDuration: Duration(milliseconds: 500),
      onTap: (index) => userBloc.setState(tabIndex: index),
      items: items,
    ),
  );
}
