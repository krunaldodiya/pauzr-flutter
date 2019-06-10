import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/user.dart';

Card getInfoCard(level, User user) {
  int rank = level['index'];
  int points = level['points'];

  return Card(
    elevation: 1.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: rank <= user.level.level
          ? Text(
              "You have successfully cleared this level.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 18.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            )
          : Text(
              "Earn ${points.toString()} points to clear this level.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
    ),
  );
}
