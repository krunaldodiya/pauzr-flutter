import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
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
  _StopPage createState() =>
      _StopPage(durationStatic: duration, durationDynamic: duration);
}

class _StopPage extends State<StopPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  var platform = MethodChannel("com.pauzr.org/info");

  int durationStatic;
  int durationDynamic;

  _StopPage({this.durationStatic, this.durationDynamic});

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

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    WidgetsBinding.instance.addObserver(this);

    setState(() {
      started = true;
    });

    double tick = waterHeight / durationStatic;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (started == true) {
        if (durationDynamic > 0) {
          setState(() {
            rotation = rotation - 1;
            durationDynamic--;
            waterController.changeWaterHeight(durationDynamic * tick);
          });
        }

        if (durationDynamic == 0) {
          setState(() {
            started = false;
            rotation = 360;
          });

          onSuccess(widget.duration, userBloc);
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

    bool status = await platform.invokeMethod("getDeviceStatus");

    switch (state) {
      case AppLifecycleState.paused:
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("pauseTime", DateTime.now().toString());

          NotificationManager(
            payload: {
              "id": notificationId,
              "title": "#DefeatThePhone",
              "body": "Tap to continue Pauzing. Be quick!",
              "status": false,
            },
            onSelectNotification: onSelectNotification,
          ).showOngoingNotification();
        }
        break;

      case AppLifecycleState.resumed:
        {
          onSelectNotification(
            json.encode({
              "id": notificationId,
              "title": "#DefeatThePhone",
              "body": "Tap to continue Pauzing. Be quick!",
              "status": status,
            }),
          );
        }
        break;

      default:
        print("default");
    }
  }

  Future onSelectNotification(String payload) async {
    Map data = json.decode(payload);
    bool status = data['status'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pauseTimeString = prefs.getString("pauseTime");

    final DateTime currentTime = DateTime.now();
    final DateTime pauseTime = DateTime.parse(pauseTimeString);

    Duration difference = currentTime.difference(pauseTime);
    int seconds = difference.inSeconds;

    if (status != true && seconds > 5) {
      prefs.remove("pauseTime");
      onFailure();
    } else {
      prefs.setString("pauseTime", DateTime.now().toString());
      print("resumed after $seconds seconds.");
    }

    NotificationManager.close(notificationId);
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

  String getTimer() {
    int seconds = durationDynamic % 60;
    int minutes = durationDynamic ~/ 60;

    String sec = seconds > 9 ? "$seconds" : "0$seconds";
    String min = minutes > 9 ? "$minutes" : "0$minutes";

    return "$min : $sec";
  }

  onFailure() {
    setState(() {
      started = false;
      rotation = 360;
    });

    showTimerPop(
      context,
      type: 'failed',
      heading: "Oops! You didn’t Pauz for $durationStatic mins.",
      points: "0",
      pointer: "Point",
      navigateAway: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }

  onSuccess(duration, UserBloc userBloc) async {
    final TimerBloc timerBloc = Provider.of<TimerBloc>(context);

    final Response response = await timerBloc.setTimer(duration);
    final results = response.data;

    await userBloc.setAuthUser(results['user']);

    String pointer = points[durationStatic] > 1 ? 'points' : 'point';

    showTimerPop(
      context,
      type: 'success',
      heading: "Congrats! You have won",
      points: points[durationStatic].toString(),
      pointer: pointer,
      navigateAway: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }
}
