import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/theme/bloc.dart';
import 'package:pauzr/src/blocs/theme/state.dart';
import 'package:pauzr/src/providers/otp.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';

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
    final otpBloc = Provider.of<OtpBloc>(context);

    return BlocBuilder(
      bloc: themeBloc,
      builder: (context, ThemeState themeState) {
        if (themeState.theme == null) {
          return CircularProgressIndicator();
        }

        DefaultTheme theme = DefaultTheme.defaultTheme(themeState.theme);

        print(otpBloc.otp);

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
                getSliderInfo(theme.intro1),
                getSliderInfo(theme.intro2),
                getSliderInfo(theme.intro3),
              ],
              onDonePress: this.onDonePress,
              onSkipPress: this.onSkipPress,
            ),
          ),
        );
      },
    );
  }

  Slide getSliderInfo(intro) {
    return Slide(
      title: intro.title,
      description: intro.description,
      pathImage: intro.pathImage,
      backgroundColor: intro.backgroundColor,
      styleTitle: TextStyle(
        fontFamily: intro.titleFontFamily,
        fontSize: intro.titleFontSize,
        color: intro.titleFontColor,
      ),
      styleDescription: TextStyle(
        fontFamily: intro.descriptionFontFamily,
        fontSize: intro.descriptionFontSize,
        color: intro.descriptionFontColor,
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
