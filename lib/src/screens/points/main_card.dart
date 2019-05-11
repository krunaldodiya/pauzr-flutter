import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

Card getMainCard(level, user) {
  int rank = level['index'];

  return Card(
    elevation: 1.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        leading: Icon(
          rank <= user.level ? Icons.check_circle : Icons.lock,
          color: rank <= user.level ? Colors.green : Colors.red,
          size: 40.0,
        ),
        title: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          child: Text(
            "LEVEL ${rank.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 16.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
        subtitle: Container(
          child: Row(
            children: <Widget>[
              Text(
                "Tap to view information",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ],
          ),
        ),
        // trailing: showTrailing(),
      ),
    ),
  );
}
