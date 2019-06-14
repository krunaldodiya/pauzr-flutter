import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';

class ViewProfilePage extends StatefulWidget {
  final bool shouldPop;

  ViewProfilePage({Key key, @required this.shouldPop}) : super(key: key);

  @override
  _ViewProfilePage createState() => _ViewProfilePage();
}

class _ViewProfilePage extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.viewProfile.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.viewProfile.backgroundColor,
        title: Text(
          userBloc.user.name.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  routeList.edit_profile,
                  arguments: {
                    "shouldPop": true,
                  },
                );
              },
            ),
            margin: EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Hero(
                  tag: 'profile-image',
                  child: Container(
                    child: ClipOval(
                      child: Image.network(
                        "$baseUrl/users/${userBloc.user.avatar}",
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: 360,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        "${userBloc.user.name.toUpperCase()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        userBloc.user.gender == 'Male'
                            ? FontAwesome.male
                            : FontAwesome.female,
                      ),
                      title: Text(
                        "${userBloc.user.gender}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.cake),
                      title: Text(
                        "${userBloc.user.dob}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.edit_location),
                      title: Text(
                        "${userBloc.user.location.city}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
