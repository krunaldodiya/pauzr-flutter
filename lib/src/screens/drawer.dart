import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  final UserBloc userBloc;
  final ThemeBloc themeBloc;

  const DrawerPage({
    Key key,
    @required this.userBloc,
    @required this.themeBloc,
  }) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = widget.themeBloc;
    final UserBloc userBloc = widget.userBloc;

    final DefaultTheme theme = themeBloc.theme;
    final User user = userBloc.user;

    return Container(
      color: theme.drawerMenu.backgroundColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
            accountEmail: Text(
              user.email,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            currentAccountPicture: Container(
              child: ClipOval(
                child: Image.network(
                  "$baseUrl/users/${user.avatar}",
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: theme.drawerMenu.topBackgroundColor,
            ),
          ),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onTap: () async {
              // Navigator.of(context).pop();
            },
          ),
          Divider(color: Colors.white),
          ListTile(
            title: Text(
              "Themes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.brush,
              color: Colors.white,
            ),
            onTap: () async {
              Navigator.pushNamed(context, routeList.manage_theme);
            },
          ),
          ListTile(
            title: Text(
              "Share",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onTap: () async {
              Share.share('check out $appName App $appId').then((data) {
                print("data");
              });
            },
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("authToken");
              prefs.remove("contacts");

              Navigator.pushReplacementNamed(
                context,
                routeList.intro,
                arguments: {
                  "shouldPop": true,
                },
              );
            },
          )
        ],
      ),
    );
  }
}
