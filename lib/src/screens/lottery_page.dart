import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/lottery.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class LotteryPage extends StatefulWidget {
  LotteryPage({Key key}) : super(key: key);

  _LotteryPageState createState() => _LotteryPageState();
}

class _LotteryPageState extends State<LotteryPage> {
  int selectedLotteryIndex;
  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);

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
          if (selectedLotteryIndex != null)
            FlatButton(
              onPressed: () {
                getLotteries(lotteryBloc);
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
            itemCount: lotteryBloc.lotteries.length,
            itemBuilder: (BuildContext context, int index) {
              int amount = lotteryBloc.lotteries[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLotteryIndex = index;
                  });
                },
                child: Container(
                  color: selectedLotteryIndex == index
                      ? Colors.greenAccent
                      : Colors.white,
                  margin: EdgeInsets.all(1.0),
                  alignment: Alignment.center,
                  child: revealed
                      ? Text(
                          amount.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: amount == 5 ? Colors.red : Colors.grey,
                            fontFamily: Fonts.titilliumWebSemiBold,
                          ),
                        )
                      : Icon(Icons.star),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getLotteries(LotteryBloc lotteryBloc) async {
    XsProgressHud.show(context);

    await lotteryBloc.getLotteries(selectedLotteryIndex);

    setState(() {
      revealed = true;
    });

    XsProgressHud.hide();
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
