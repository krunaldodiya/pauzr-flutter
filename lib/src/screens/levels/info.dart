import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/screens/levels/info_card.dart';
import 'package:pauzr/src/screens/levels/levels.dart';
import 'package:pauzr/src/screens/levels/main_card.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key key}) : super(key: key);

  @override
  _LevelPage createState() => _LevelPage();
}

class _LevelPage extends State<LevelPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                  child: getMainCard(level),
                ),
                back: Container(
                  child: getInfoCard(level),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getList() {
    List<Widget> list = [];

    list.add(Container(height: 10.0));

    for (var i = 0; i < 10; i++) {
      final int rank = i + 1;

      list.add(getMainCard(rank));
    }

    return list;
  }
}
