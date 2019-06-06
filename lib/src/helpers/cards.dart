import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

getCard(
  String topText,
  String bottomText,
  double topHeight,
  double bottomHeight,
  theme,
) {
  return Card(
    color: Colors.transparent,
    child: Column(
      children: <Widget>[
        Container(
          height: topHeight,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: theme.cardTopBackgroundColor,
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
          height: bottomHeight,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: theme.cardBottomBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              bottomText,
              textAlign: TextAlign.center,
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
