import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/tabs.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/drawer.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPage createState() => _TabsPage();
}

class _TabsPage extends State<TabsPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.tabs.backgroundColor,
      appBar: getAppBar(context, userBloc, theme),
      body: SafeArea(
        child: getTabsPage(userBloc.tabIndex),
      ),
      bottomNavigationBar: getNavigationBar(userBloc, theme),
      drawer: Drawer(
        child: DrawerPage(userBloc: userBloc, themeBloc: themeBloc),
      ),
    );
  }

  Container getNavigationBar(UserBloc userBloc, DefaultTheme theme) {
    var data = getTabsTheme(userBloc.tabIndex, theme);

    return Container(
      color: Colors.transparent,
      height: 50.0,
      child: CurvedNavigationBar(
        initialIndex: userBloc.tabIndex,
        color: data.navigationColor,
        backgroundColor: data.navigationBackgroundColor,
        buttonBackgroundColor: data.navigationButtonBackgroundColor,
        animationCurve: Curves.easeOutCubic,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          userBloc.setState(tabIndex: index);
        },
        items: <Widget>[
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
            Ionicons.ios_trophy,
            color: Colors.white,
            size: 25.0,
          ),
        ],
      ),
    );
  }

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
              },
            );
          },
          child: Hero(
            tag: "profile-image",
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ClipOval(
                child: Image.network(
                  "$baseUrl/users/${userBloc.user.avatar}",
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
}
