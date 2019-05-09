import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

getCard(level) {
  return Card(
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.blue],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 29.0,
                alignment: Alignment.bottomCenter,
                child: Text(
                  "LEVEL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: Fonts.titilliumWebBold,
                  ),
                ),
              ),
              Container(
                height: 100.0,
                alignment: Alignment.center,
                child: Text(
                  level.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 62.0,
                    fontFamily: Fonts.titilliumWebBold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 70.0,
          alignment: Alignment.center,
          child: Icon(
            level < 3 ? Icons.check_circle : Icons.lock,
            color: level < 3 ? Colors.green : Colors.red,
            size: 36.0,
          ),
        ),
      ],
    ),
  );
}
