import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/notifications.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/timer.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waveprogressbar_flutter/waveprogressbar_flutter.dart';

class StopPage extends StatefulWidget {
  final int duration;

  StopPage({Key key, @required this.duration}) : super(key: key);

  @override
  _StopPage createState() {
    return _StopPage(
      durationStatic: duration,
      durationDynamic: duration,
      timerMinutes: duration ~/ 60,
    );
  }
}

class _StopPage extends State<StopPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final EventChannel eventChannel = EventChannel('com.pauzr.org/info');

  int durationStatic;
  int durationDynamic;
  int timerMinutes;

  _StopPage({
    this.durationStatic,
    this.durationDynamic,
    this.timerMinutes,
  });

  double waterHeight = 0.9;
  double rotation = 360;

  WaterController waterController = WaterController();

  bool started;
  int notificationId = 1;

  var timer;

  Map points = {20: 1, 40: 3, 60: 5};

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
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final TimerBloc timerBloc = Provider.of<TimerBloc>(context);

    WidgetsBinding.instance.addObserver(this);

    setState(() {
      started = true;
    });

    double tickValue = waterHeight / durationStatic;
    double rotateValue = 1;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (started == true) {
        if (durationDynamic > 0) {
          setState(() {
            rotation = rotation - rotateValue;
            durationDynamic--;
            waterController.changeWaterHeight(durationDynamic * tickValue);
          });
        }

        if (durationDynamic == 0) {
          setState(() {
            started = false;
            rotation = 360;
            waterController.changeWaterHeight(0);
          });

          onSuccess(widget.duration, userBloc, timerBloc);
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    timer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (state) {
      case AppLifecycleState.paused:
        {
          Future.delayed(Duration(seconds: 1), () async {
            final String screenStatus = prefs.getString("screenStatus");

            if (screenStatus == "ACTION_SCREEN_ON") {
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

      if (seconds > 5) {
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
            setState(() {
              started = false;
              rotation = 360;
            });

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
                        angle: rotation,
                        child: Image.asset(
                          "assets/images/hello.png",
                          height: 310.0,
                          width: 310.0,
                          color: theme.stop.handBackgroundColor,
                        ),
                      ),
                      WaveProgressBar(
                        flowSpeed: 0.1,
                        waveDistance: 45.0,
                        waveHeight: 18.0,
                        waterColor: theme.stop.waterColor,
                        strokeCircleColor: theme.stop.strokeCircleColor,
                        circleStrokeWidth: 2.0,
                        heightController: waterController,
                        percentage: waterHeight,
                        size: Size(220, 220),
                        textStyle: TextStyle(
                          fontSize: 0.0,
                        ),
                      ),
                      Text(
                        getTimer(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: theme.stop.timerColor,
                          fontFamily: Fonts.titilliumWebBold,
                        ),
                      )
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
                          setState(() {
                            started = false;
                            rotation = 360;
                          });

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
                setState(() {
                  started = false;
                });
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
    final now = Duration(seconds: durationDynamic);

    String twoDigitMinutes = twoDigits(
      now.inMinutes > 0 && now.inMinutes.remainder(60) == 0
          ? 60
          : now.inMinutes.remainder(60),
    );

    String twoDigitSeconds = twoDigits(now.inSeconds.remainder(60));

    return "$twoDigitMinutes : $twoDigitSeconds";
  }

  onFailure() {
    setState(() {
      started = false;
      rotation = 360;
    });

    showTimerPop(
      context,
      type: 'failed',
      heading: "Oops! You didn’t Pauz for $timerMinutes mins.",
      points: "0",
      pointer: "Point",
      navigateAway: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }

  onSuccess(duration, UserBloc userBloc, TimerBloc timerBloc) async {
    await timerBloc.setTimer(timerMinutes, userBloc);

    String pointer = points[durationStatic] > 1 ? 'points' : 'point';

    showTimerPop(
      context,
      type: 'success',
      heading: "Congrats! You have won",
      points: points[timerMinutes].toString(),
      pointer: pointer,
      navigateAway: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }
}
