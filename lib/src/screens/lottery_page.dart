import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/admob.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/models/wallet.dart';
import 'package:pauzr/src/providers/lottery.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:pauzr/src/screens/helpers/error.dart';
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

  InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);

    lotteryBloc.setLotteries(60);

    FirebaseAdMob.instance.initialize(appId: admobAppId);

    _interstitialAd = createInterstitialAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _interstitialAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.addGroupParticipants.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.addGroupParticipants.appBackgroundColor,
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
          if (selectedLotteryIndex != null && revealed == false)
            FlatButton(
              onPressed: () {
                showConfirmationPopup(
                  context,
                  message: "1 card = 20 points. Are you sure ?",
                  onPressYes: () {
                    getLotteries(lotteryBloc, userBloc);
                  },
                );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "My Points: ${userBloc.user.wallet.balance}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: Fonts.titilliumWebSemiBold,
                    ),
                  ),
                  RaisedButton(
                    color: theme.addGroupParticipants.appBackgroundColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 0.0,
                    ),
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, routeList.earnings);
                    },
                    child: Text(
                      "My Earnings",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.white,
                        fontFamily: Fonts.titilliumWebSemiBold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
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
                              : revealed ? Colors.white : Color(0xffFFD700),
                        ),
                        margin: EdgeInsets.all(1.0),
                        alignment: Alignment.center,
                        child: revealed
                            ? Text(
                                amount == 0
                                    ? "Better Luck Next Time"
                                    : "₹${amount.toString()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: amount == 0 ? 16.0 : 18.0,
                                  color: getColor(amount),
                                  fontFamily: Fonts.titilliumWebSemiBold,
                                ),
                              )
                            : Icon(
                                Ionicons.ios_gift,
                                color: Color(0xff0D62A2),
                                size: 42.0,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
      Map results = await lotteryBloc.getLotteries(selectedLotteryIndex);
      await lotteryBloc.getLotteryWinners();
      XsProgressHud.hide();

      if (results['lotteries'] == null) {
        showErrorPopup(
          context,
          message: "You don't have enough points, 1 card = 20 points.",
        );
      } else {
        final int amount = results['lotteries'][selectedLotteryIndex];

        final User userData = userBloc.user.copyWith({
          "wallet": Wallet.fromMap(results['wallet']),
        });

        userBloc.setState(user: userData);

        showErrorPopup(
          context,
          message: amount > 0
              ? "Congratulations! You have won ₹$amount."
              : "Sorry! Better luck next time.",
        );

        setState(() => revealed = true);
      }
    } catch (error) {
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
