import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageTheme extends StatefulWidget {
  ManageTheme({Key key}) : super(key: key);

  _ManageThemeState createState() => _ManageThemeState();
}

class _ManageThemeState extends State<ManageTheme> {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Manage Theme",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getLable(
                themeBloc: themeBloc,
                text: "black",
                borderColor: Colors.white,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
              getLable(
                themeBloc: themeBloc,
                text: "red",
                borderColor: Colors.white,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              ),
              getLable(
                themeBloc: themeBloc,
                text: "blue",
                borderColor: Colors.white,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell getLable({
    ThemeBloc themeBloc,
    text,
    borderColor,
    backgroundColor,
    textColor,
  }) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("defaultTheme", text);

        DefaultTheme defaultTheme = DefaultTheme.defaultTheme(text);
        themeBloc.setTheme(defaultTheme);

        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(5.0),
        width: 100.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: textColor,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      ),
    );
  }
}
