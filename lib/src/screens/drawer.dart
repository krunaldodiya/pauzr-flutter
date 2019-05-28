import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

class DrawerPage extends StatelessWidget {
  final User user;
  const DrawerPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

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
              appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            color: Colors.white,
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
              Share.share('check out Pauzr App $appId').then((data) {
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
