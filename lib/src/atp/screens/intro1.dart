import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:meta/meta.dart';

class Intro1 {
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

  Intro1({
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

  factory Intro1.initial() {
    return Intro1(
      backgroundColor: Colors.black87,
      title: "ERASER",
      description:
          "Allow miles wound place the leave had. To sitting subject no improve studied limited",
      pathImage: "assets/images/photo_eraser.png",
      titleFontFamily: Fonts.titilliumWebRegular,
      titleFontSize: 28.0,
      titleFontColor: Colors.white,
      descriptionFontFamily: Fonts.titilliumWebRegular,
      descriptionFontSize: 22.0,
      descriptionFontColor: Colors.white,
    );
  }
}
