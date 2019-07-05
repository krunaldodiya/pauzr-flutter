import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePage createState() => _StorePage();
}

class _StorePage extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.groupScoreboard.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Icon(
                MaterialCommunityIcons.truck_fast,
                size: 90.0,
                color: Colors.black,
              ),
            ),
            Container(height: 20.0),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Coming Soon",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20.0),
              child: Text(
                "Loading the PauzR truck with some breathtaking deals for you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
