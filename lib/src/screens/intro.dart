import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:intro_slider/intro_slider.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IntroPage createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  DefaultTheme theme;

  @override
  void initState() {
    setState(() {
      theme = ThemeProvider.defaultTheme();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.intro.backgroundColor,
      body: SafeArea(
        child: IntroSlider(
          colorActiveDot: Colors.black,
          colorDot: Colors.white,
          styleNameDoneBtn: TextStyle(
            color: Colors.black,
          ),
          styleNamePrevBtn: TextStyle(
            color: Colors.black,
          ),
          styleNameSkipBtn: TextStyle(
            color: Colors.black,
          ),
          slides: [
            Slide(
              title: theme.intro1.title,
              description: theme.intro1.description,
              pathImage: theme.intro1.pathImage,
              backgroundColor: theme.intro1.backgroundColor,
              styleTitle: TextStyle(
                fontFamily: theme.intro1.titleFontFamily,
                fontSize: theme.intro1.titleFontSize,
                color: theme.intro1.titleFontColor,
              ),
              styleDescription: TextStyle(
                fontFamily: theme.intro1.descriptionFontFamily,
                fontSize: theme.intro1.descriptionFontSize,
                color: theme.intro1.descriptionFontColor,
              ),
            ),
            Slide(
              title: theme.intro2.title,
              description: theme.intro2.description,
              pathImage: theme.intro2.pathImage,
              backgroundColor: theme.intro2.backgroundColor,
              styleTitle: TextStyle(
                fontFamily: theme.intro2.titleFontFamily,
                fontSize: theme.intro2.titleFontSize,
                color: theme.intro2.titleFontColor,
              ),
              styleDescription: TextStyle(
                fontFamily: theme.intro2.descriptionFontFamily,
                fontSize: theme.intro2.descriptionFontSize,
                color: theme.intro2.descriptionFontColor,
              ),
            ),
            Slide(
              title: theme.intro3.title,
              description: theme.intro3.description,
              pathImage: theme.intro3.pathImage,
              backgroundColor: theme.intro3.backgroundColor,
              styleTitle: TextStyle(
                fontFamily: theme.intro3.titleFontFamily,
                fontSize: theme.intro3.titleFontSize,
                color: theme.intro3.titleFontColor,
              ),
              styleDescription: TextStyle(
                fontFamily: theme.intro3.descriptionFontFamily,
                fontSize: theme.intro3.descriptionFontSize,
                color: theme.intro3.descriptionFontColor,
              ),
            ),
          ],
          onDonePress: this.onDonePress,
          onSkipPress: this.onSkipPress,
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, routeList.request_otp);
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, routeList.request_otp);
  }
}
