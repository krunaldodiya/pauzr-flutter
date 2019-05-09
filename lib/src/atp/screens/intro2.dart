import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:meta/meta.dart';

class Intro2 {
  var backgroundColor;
  String title;
  String description;
  String pathImage;
  String titleFontFamily;
  double titleFontSize;
  var titleFontColor;
  String descriptionFontFamily;
  double descriptionFontSize;
  var descriptionFontColor;

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
      title: "PENCIL",
      description: "Ye indulgence unreserved connection alteration appearance",
      pathImage: "assets/images/photo_pencil.png",
      titleFontFamily: Fonts.titilliumWebRegular,
      titleFontSize: 28.0,
      titleFontColor: Colors.white,
      descriptionFontFamily: Fonts.titilliumWebRegular,
      descriptionFontSize: 22.0,
      descriptionFontColor: Colors.white,
    );
  }
}
