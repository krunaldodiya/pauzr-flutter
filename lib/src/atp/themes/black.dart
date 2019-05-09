import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/provider.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';

class Black implements DefaultTheme {
  @override
  Intro1 intro1 = Intro1(
    backgroundColor: Colors.black,
    title: Intro1.initial().title,
    description: Intro1.initial().description,
    pathImage: Intro1.initial().pathImage,
    titleFontColor: Colors.white,
    titleFontFamily: Intro1.initial().titleFontFamily,
    titleFontSize: Intro1.initial().titleFontSize,
    descriptionFontColor: Colors.white,
    descriptionFontFamily: Intro1.initial().descriptionFontFamily,
    descriptionFontSize: Intro1.initial().descriptionFontSize,
  );

  Intro2 intro2 = Intro2(
    backgroundColor: Colors.black,
    title: Intro2.initial().title,
    description: Intro2.initial().description,
    pathImage: Intro2.initial().pathImage,
    titleFontColor: Colors.white,
    titleFontFamily: Intro2.initial().titleFontFamily,
    titleFontSize: Intro2.initial().titleFontSize,
    descriptionFontColor: Colors.white,
    descriptionFontFamily: Intro2.initial().descriptionFontFamily,
    descriptionFontSize: Intro2.initial().descriptionFontSize,
  );

  Intro3 intro3 = Intro3(
    backgroundColor: Colors.black,
    title: Intro3.initial().title,
    description: Intro3.initial().description,
    pathImage: Intro3.initial().pathImage,
    titleFontColor: Colors.white,
    titleFontFamily: Intro3.initial().titleFontFamily,
    titleFontSize: Intro3.initial().titleFontSize,
    descriptionFontColor: Colors.white,
    descriptionFontFamily: Intro3.initial().descriptionFontFamily,
    descriptionFontSize: Intro3.initial().descriptionFontSize,
  );
}
