import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/theme/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class ManageTheme extends StatefulWidget {
  ManageTheme({Key key}) : super(key: key);

  _ManageThemeState createState() => _ManageThemeState();
}

class _ManageThemeState extends State<ManageTheme> {
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
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Manage Theme",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getLable(
                text: "Black",
                borderColor: Colors.white,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
              getLable(
                text: "Red",
                borderColor: Colors.white,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell getLable({text, borderColor, backgroundColor, textColor}) {
    return InkWell(
      onTap: () async {
        themeBloc.setTheme(text);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(5.0),
        width: 100.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: textColor,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      ),
    );
  }
}
