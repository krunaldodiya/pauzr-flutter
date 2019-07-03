import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

import 'src/atp/default.dart';

AppBar getAppBar(
  BuildContext context,
  UserBloc userBloc,
  DefaultTheme theme,
) {
  return AppBar(
    centerTitle: true,
    elevation: 0.5,
    backgroundColor: theme.tabs.appBarBackgroundColor,
    textTheme: TextTheme(
      title: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: Fonts.titilliumWebRegular,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    title: Text(
      getTitle(userBloc),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: Fonts.titilliumWebRegular,
      ),
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeList.view_profile,
            arguments: {
              "shouldPop": true,
              "user": userBloc.user,
            },
          );
        },
        child: Hero(
          tag: "profile-image",
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/storage/${userBloc.user.avatar}",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 36.0,
                height: 36.0,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.0),
      )
    ],
  );
}

String getTitle(UserBloc userBloc) {
  String title;

  if (userBloc.tabIndex == 0) {
    title = "Groups";
  }

  if (userBloc.tabIndex == 1) {
    title = appName;
  }

  if (userBloc.tabIndex == 2) {
    title = "Scoreboard";
  }

  return title;
}
