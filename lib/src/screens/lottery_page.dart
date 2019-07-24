import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotteryPage extends StatefulWidget {
  LotteryPage({Key key}) : super(key: key);

  _LotteryPageState createState() => _LotteryPageState();
}

class _LotteryPageState extends State<LotteryPage> {
  int selectedLotteryNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color(0xff0D62A2),
        title: Text(
          "Lottery",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
        actions: <Widget>[
          if (selectedLotteryNumber != null)
            FlatButton(
              onPressed: () {
                print("object");
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebSemiBold,
                ),
              ),
            )
        ],
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              int number = index + 1;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLotteryNumber = number;
                  });
                },
                child: Container(
                  color: selectedLotteryNumber == number
                      ? Colors.greenAccent
                      : Colors.white,
                  margin: EdgeInsets.all(1.0),
                  alignment: Alignment.center,
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: Fonts.titilliumWebSemiBold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InkWell getLable({
    ThemeBloc themeBloc,
    text,
    borderColor,
    backgroundColor,
    textColor,
  }) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("defaultTheme", text);

        DefaultTheme defaultTheme = DefaultTheme.defaultTheme(text);
        themeBloc.setTheme(defaultTheme);

        Navigator.pop(context);
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
          text.toUpperCase(),
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
