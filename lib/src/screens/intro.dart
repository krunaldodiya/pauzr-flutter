import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/theme/bloc.dart';
import 'package:pauzr/src/blocs/theme/state.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IntroPage createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  ThemeBloc themeBloc;

  @override
  void initState() {
    setState(() {
      themeBloc = BlocProvider.of<ThemeBloc>(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: themeBloc,
      builder: (context, ThemeState themeState) {
        if (themeState.theme == null) {
          return CircularProgressIndicator();
        }

        DefaultTheme theme = DefaultTheme.defaultTheme(themeState.theme);

        return Scaffold(
          backgroundColor: theme.intro.backgroundColor,
          body: SafeArea(
            child: IntroSlider(
              colorActiveDot: theme.intro.colorActiveDot,
              colorDot: theme.intro.colorDot,
              styleNameDoneBtn: TextStyle(
                color: theme.intro.doneBtnColor,
              ),
              styleNamePrevBtn: TextStyle(
                color: theme.intro.prevBtnColor,
              ),
              styleNameSkipBtn: TextStyle(
                color: theme.intro.skipBtnColor,
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
      },
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, routeList.request_otp);
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, routeList.request_otp);
  }
}
