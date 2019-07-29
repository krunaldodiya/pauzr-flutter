import 'dart:async';
import 'dart:convert';

import 'package:countdown/countdown.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/admob.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/notifications.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/timer.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StopPage extends StatefulWidget {
  final int duration;

  StopPage({Key key, @required this.duration}) : super(key: key);

  @override
  _StopPage createState() {
    return _StopPage(
      durationSeconds: duration,
      durationMintues: duration ~/ 60,
    );
  }
}

class _StopPage extends State<StopPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final EventChannel eventChannel = EventChannel('com.pauzr.org/info');

  int durationSeconds;
  int durationMintues;

  _StopPage({this.durationSeconds, this.durationMintues});

  Map points = {1: 0, 2: 0, 3: 0, 20: 1, 40: 3, 60: 5};

  int notificationId = 1;
  var timerSubscription;

  InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();

    listenToScreenStatus();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  void listenToScreenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    eventChannel.receiveBroadcastStream().listen((Object event) async {
      prefs.setString("screenStatus", event);
    });
  }

  getInitialData() async {
    WidgetsBinding.instance.addObserver(this);

    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final TimerBloc timerBloc = Provider.of<TimerBloc>(context);

    FirebaseAdMob.instance.initialize(appId: admobAppId);

    _interstitialAd = createInterstitialAd(userBloc.adsKeywords)
      ..load()
      ..show();

    CountDown cd = CountDown(
      Duration(seconds: widget.duration),
      refresh: Duration(seconds: 1),
    );

    timerSubscription = cd.stream.listen(null);

    timerSubscription.onData((Duration duration) {
      setState(() {
        durationSeconds = duration.inSeconds;
      });
    });

    timerSubscription.onDone(() {
      onSuccess(widget.duration, userBloc, timerBloc);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _interstitialAd.dispose();

    onFailure();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (state) {
      case AppLifecycleState.paused:
        {
          Future.delayed(Duration(seconds: 2), () async {
            final String screenStatus = prefs.getString("screenStatus");

            if (screenStatus != "ACTION_SCREEN_OFF") {
              prefs.setString("pauseTime", DateTime.now().toString());

              NotificationManager(
                payload: {
                  "id": notificationId,
                  "title": "#DefeatThePhone",
                  "body": "Tap to continue Pauzing. Be quick!",
                },
                onSelectNotification: onSelectNotification,
              ).showOngoingNotification();
            }
          });
        }
        break;

      case AppLifecycleState.resumed:
        {
          onSelectNotification(
            json.encode({
              "id": notificationId,
              "title": "#DefeatThePhone",
              "body": "Tap to continue Pauzing. Be quick!",
            }),
          );
        }
        break;

      default:
        print("default");
    }
  }

  Future onSelectNotification(String payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pauseTimeString = prefs.getString("pauseTime");

    if (pauseTimeString != null) {
      final DateTime currentTime = DateTime.now();
      final DateTime pauseTime = DateTime.parse(pauseTimeString);

      Duration difference = currentTime.difference(pauseTime);
      int seconds = difference.inSeconds;

      if (seconds > 3) {
        onFailure();
      }

      prefs.remove("pauseTime");

      NotificationManager.close(notificationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return WillPopScope(
      onWillPop: () async {
        return showConfirmationPopup(
          context,
          yesText: "Yes",
          noText: "No",
          message: "Are you sure ?",
          onPressYes: () {
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        backgroundColor: theme.stop.backgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Transform.rotate(
                        angle: durationSeconds.toDouble(),
                        child: Image.asset(
                          "assets/images/hello.png",
                          height: 340.0,
                          width: 340.0,
                          color: theme.stop.handBackgroundColor,
                        ),
                      ),
                      Container(
                        width: 240.0,
                        height: 240.0,
                        child: LiquidCircularProgressIndicator(
                          value: 0.95 * durationSeconds / widget.duration,
                          valueColor: AlwaysStoppedAnimation(
                            theme.stop.waterColor,
                          ),
                          backgroundColor: theme.stop.backgroundColor,
                          borderColor: theme.stop.strokeCircleColor,
                          borderWidth: 1.0,
                          direction: Axis.vertical,
                          center: Text(
                            getTimer(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: theme.stop.timerColor,
                              fontFamily: Fonts.titilliumWebBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      return showConfirmationPopup(
                        context,
                        yesText: "Yes",
                        noText: "No",
                        message: "Want to stop Pauzing?",
                        onPressYes: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Icon(
                      FontAwesome.remove,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showTimerPop(
    BuildContext context, {
    String type,
    String heading,
    String points,
    String pointer,
    Function navigateAway,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff70B3DD),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                heading,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Colors.black,
                ),
              ),
              Container(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    points,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 64.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.titilliumWebRegular,
                      color: Colors.white,
                    ),
                  ),
                  Container(width: 10.0),
                  Text(
                    pointer,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.titilliumWebRegular,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(height: 10.0),
              Text(
                "Keep Pauzing!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Color(0xff0D62A2),
                ),
              ),
              Container(height: 10.0),
              Text(
                "#DefeatThePhone",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Colors.black,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              color: type == 'success' ? Color(0xff0D62A2) : Colors.red,
              child: Text(
                "Okay",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                navigateAway();
              },
            ),
          ],
        );
      },
    );
  }

  String twoDigits(int n) {
    return (n >= 10) ? "$n" : "0$n";
  }

  String getTimer() {
    final now = Duration(seconds: durationSeconds);

    String twoDigitMinutes = twoDigits(
      now.inMinutes > 0 && now.inMinutes.remainder(60) == 0
          ? 60
          : now.inMinutes.remainder(60),
    );

    String twoDigitSeconds = twoDigits(now.inSeconds.remainder(60));

    return "$twoDigitMinutes : $twoDigitSeconds";
  }

  onFailure() {
    print("failure");

    timerSubscription.cancel();

    showTimerPop(
      context,
      type: 'failed',
      heading: "Oops! You didn’t Pauz for $durationMintues mins.",
      points: "0",
      pointer: "Point",
      navigateAway: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }

  onSuccess(duration, UserBloc userBloc, TimerBloc timerBloc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("pauseTime");

    await timerBloc.setTimer(durationMintues, userBloc);

    int achievedPoints = points[durationMintues];

    String pointer = achievedPoints > 1 ? 'points' : 'point';

    showTimerPop(
      context,
      type: 'success',
      heading: "Congrats! You have won",
      points: achievedPoints.toString(),
      pointer: pointer,
      navigateAway: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }
}
