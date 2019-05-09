import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

getInfoCard(level) {
  return Card(
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.dstATop,
          ),
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Text(
        "Info",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontFamily: Fonts.titilliumWebSemiBold,
        ),
      ),
    ),
  );
}
