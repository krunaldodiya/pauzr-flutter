import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

Container showTrailing() {
  return Container(
    child: Column(
      children: <Widget>[
        Text(
          "300",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 22.0,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
        Text(
          "Minutes",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 12.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ],
    ),
  );
}
