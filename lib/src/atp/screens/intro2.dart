import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:meta/meta.dart';

class Intro2 {
  Color backgroundColor;
  String title;
  String description;
  String pathImage;
  String titleFontFamily;
  double titleFontSize;
  Color titleFontColor;
  String descriptionFontFamily;
  double descriptionFontSize;
  Color descriptionFontColor;

  Intro2({
    @required this.backgroundColor,
    @required this.title,
    @required this.description,
    @required this.pathImage,
    @required this.titleFontFamily,
    @required this.titleFontSize,
    @required this.titleFontColor,
    @required this.descriptionFontFamily,
    @required this.descriptionFontSize,
    @required this.descriptionFontColor,
  });

  factory Intro2.initial() {
    return Intro2(
      backgroundColor: Colors.black87,
      title: "Earn Points",
      description: "Earn points for not using the phone",
      pathImage: "assets/images/intro/2.png",
      titleFontFamily: Fonts.titilliumWebRegular,
      titleFontSize: 28.0,
      titleFontColor: Colors.white,
      descriptionFontFamily: Fonts.titilliumWebRegular,
      descriptionFontSize: 22.0,
      descriptionFontColor: Colors.white,
    );
  }
}
