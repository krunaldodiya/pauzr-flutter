import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/admob.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/lottery.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/helpers/confirm.dart';
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
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    RewardedVideoAd.instance.listener = getRewardedVideoAd;
  }

  getRewardedVideoAd(
    RewardedVideoAdEvent event, {
    String rewardType,
    int rewardAmount,
  }) {
    if (event == RewardedVideoAdEvent.loaded) {
      RewardedVideoAd.instance
          .load(adUnitId: admobVideoAdUnitId, targetingInfo: getTargetingInfo())
          .then((status) => RewardedVideoAd.instance.show());
    }
  }

  @override
  Widget build(BuildContext context) {
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color(0xff0D62A2),
        title: Text(
          "Lottery - ${userBloc.user.wallet.balance} points",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
        actions: <Widget>[
          if (selectedLotteryIndex != null && revealed == false)
            FlatButton(
              onPressed: () {
                showConfirmationPopup(context, onPressYes: () {
                  getLotteries(lotteryBloc, userBloc);
                });
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
          padding: EdgeInsets.all(2.0),
          alignment: Alignment.center,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: lotteryBloc.lotteries.length,
            itemBuilder: (BuildContext context, int index) {
              int amount = lotteryBloc.lotteries[index];

              return GestureDetector(
                onTap: () {
                  if (revealed == false) {
                    setState(() {
                      selectedLotteryIndex = index;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: selectedLotteryIndex == index
                        ? Colors.greenAccent
                        : Colors.white,
                  ),
                  margin: EdgeInsets.all(1.0),
                  alignment: Alignment.center,
                  child: revealed
                      ? Text(
                          amount.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: getColor(amount),
                            fontFamily: Fonts.titilliumWebSemiBold,
                          ),
                        )
                      : Icon(
                          Ionicons.ios_gift,
                          color: Colors.grey,
                          size: 42.0,
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getColor(amount) {
    Color color = Colors.grey;

    if (amount == 5) {
      color = Colors.red;
    }

    if (amount == 10) {
      color = Colors.purple;
    }

    if (amount == 20) {
      color = Colors.blue;
    }

    if (amount == 50) {
      color = Colors.green;
    }

    if (amount == 100) {
      color = Colors.black;
    }

    return color;
  }

  getLotteries(LotteryBloc lotteryBloc, UserBloc userBloc) async {
    XsProgressHud.show(context);

    try {
      await lotteryBloc.getLotteries(selectedLotteryIndex);
      await lotteryBloc.getLotteryWinners();

      setState(() {
        revealed = true;
      });

      XsProgressHud.hide();
    } catch (e) {
      XsProgressHud.hide();
    }
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
