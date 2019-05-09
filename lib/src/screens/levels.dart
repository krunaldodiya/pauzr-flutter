import 'package:flutter/material.dart';
import 'package:pauzr/src/screens/tabs/level_cards.dart';
import 'package:flip_card/flip_card.dart';
import 'package:pauzr/src/screens/tabs/level_info_cards.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key key}) : super(key: key);

  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  List levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Levels".toUpperCase()),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemCount: levels.length,
            itemBuilder: (context, int index) {
              final level = levels[index];

              return FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  margin: EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      //
                    },
                    child: getCard(level),
                  ),
                ),
                back: Container(
                  margin: EdgeInsets.all(5.0),
                  child: getInfoCard(level),
                ),
              );

              // return getLevelCard(level);
            },
          ),
        ),
      ),
    );
  }
}
