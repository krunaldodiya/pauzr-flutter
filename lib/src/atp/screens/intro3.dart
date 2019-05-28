import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:meta/meta.dart';

class Intro3 {
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

  Intro3({
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

  factory Intro3.initial() {
    return Intro3(
      backgroundColor: Colors.black87,
      title: "RULER",
      description:
          "Much evil soon high in hope do view. Out may few northward believing attempted.",
      pathImage: "assets/images/photo_ruler.png",
      titleFontFamily: Fonts.titilliumWebRegular,
      titleFontSize: 28.0,
      titleFontColor: Colors.white,
      descriptionFontFamily: Fonts.titilliumWebRegular,
      descriptionFontSize: 22.0,
      descriptionFontColor: Colors.white,
    );
  }
}
