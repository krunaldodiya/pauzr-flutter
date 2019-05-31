import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
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
  int showTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.tabs.backgroundColor,
      appBar: getAppBar(context, userBloc, theme),
      body: SafeArea(
        child: getTabsPage(showTabIndex),
      ),
      bottomNavigationBar: getNavigationBar(context, theme),
      drawer: Drawer(
        child: DrawerPage(userBloc: userBloc, themeBloc: themeBloc),
      ),
    );
  }

  Container getNavigationBar(context, DefaultTheme theme) {
    var data = getTabsTheme(showTabIndex, theme);

    return Container(
      color: Colors.transparent,
      height: 50.0,
      child: CurvedNavigationBar(
        initialIndex: 1,
        color: data.navigationColor,
        backgroundColor: data.navigationBackgroundColor,
        buttonBackgroundColor: data.navigationButtonBackgroundColor,
        animationCurve: Curves.easeOutCubic,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            showTabIndex = index;
          });
        },
        items: <Widget>[
          Icon(
            Icons.group,
            color: Colors.white,
            size: 25.0,
          ),
          Icon(
            Icons.pause,
            color: Colors.white,
            size: 25.0,
          ),
          Icon(
            Icons.dashboard,
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
        "Pauzr",
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
}
