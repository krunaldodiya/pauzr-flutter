import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/launch_url.dart';
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
                child: CachedNetworkImage(
                  imageUrl: "$baseUrl/storage/${user.avatar}",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
              "Lottery",
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
              Navigator.pushNamed(context, routeList.lottery);
            },
          ),
          Divider(color: Colors.white),
          ListTile(
            title: Text(
              "Invite & Earn",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Ionicons.logo_whatsapp,
              color: Colors.white,
            ),
            onTap: () async {
              Navigator.pushNamed(context, routeList.invite);
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
              Share.share(shareText).then((data) {
                print("data");
              });
            },
          ),
          ListTile(
            title: Text(
              "Rate & Review us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL(appId);
            },
          ),
          ListTile(
            title: Text(
              "Like us on Facebook",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Ionicons.logo_facebook,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL("https://www.facebook.com/pauzrapp");
            },
          ),
          Divider(color: Colors.white),
          ListTile(
            title: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL("$webUrl/terms");
            },
          ),
          ListTile(
            title: Text(
              "Have any query ?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL("mailto:$emailAddress");
            },
          ),
          ListTile(
            title: Text(
              "FAQs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: Icon(
              Icons.question_answer,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL("$webUrl/faqs");
            },
          ),
          Divider(color: Colors.white),
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
