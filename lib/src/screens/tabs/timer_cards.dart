import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';

getCard(String topText, String bottomText, DefaultTheme theme) {
  return Card(
    color: Colors.transparent,
    child: Column(
      children: <Widget>[
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              topText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 36.0,
                fontFamily: Fonts.titilliumWebBold,
              ),
            ),
          ),
        ),
        Container(
          height: 42.0,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              bottomText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebBold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
