import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/levels/info_card.dart';
import 'package:pauzr/src/screens/levels/levels.dart';
import 'package:pauzr/src/screens/levels/main_card.dart';
import 'package:provider/provider.dart';

class LevelsPage extends StatefulWidget {
  LevelsPage({Key key}) : super(key: key);

  @override
  _LevelsPage createState() => _LevelsPage();
}

class _LevelsPage extends State<LevelsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.levels.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.levels.appBackgroundColor,
        title: Text(
          "Levels".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 4.3,
            ),
            itemCount: levels.length,
            itemBuilder: (context, int index) {
              final level = levels[index];

              return FlipCard(
                direction: FlipDirection.VERTICAL,
                front: Container(
                  child: getMainCard(level, userBloc.user),
                ),
                back: Container(
                  child: getInfoCard(level, userBloc.user),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
