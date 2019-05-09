import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

getCard(topText, bottomText) {
  return Card(
    child: Column(
      children: <Widget>[
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.blue],
            ),
          ),
          child: Center(
            child: Text(
              topText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 36.0,
                fontFamily: Fonts.titilliumWebBold,
              ),
            ),
          ),
        ),
        Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              bottomText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
