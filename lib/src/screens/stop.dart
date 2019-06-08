import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/notifications.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/timer.dart';
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
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
  int durationStatic;
  int durationDynamic;

  _StopPage({this.durationStatic, this.durationDynamic});

  double waterHeight = 0.9;
  double rotation = 360;

  WaterController waterController = WaterController();

  bool started;
  int notificationId = 1;

  int pauseTime;
  var timer;

  Map points = {20: 1, 40: 3, 60: 3};

  @override
  void initState() {
    super.initState();

    getInitialData();
  }

  getInitialData() {
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

          onSuccess(widget.duration);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        {
          setState(() {
            pauseTime = durationDynamic;
          });

          NotificationManager(
            id: notificationId,
            title: "Pauzr",
            body: "Tap to go back",
            onSelectNotification: onSelectNotification,
          ).showOngoingNotification();
        }
        break;

      case AppLifecycleState.resumed:
        NotificationManager.close(notificationId);
        break;

      default:
        print("default");
    }
  }

  Future onSelectNotification(String payload) async {
    int seconds = pauseTime - durationDynamic;

    if (seconds > 5) {
      setState(() {
        started = false;
        rotation = 360;
      });

      String message = "You didn’t Pauz for $durationStatic mins.";

      showTimerPop(
        context,
        type: 'failed',
        message: message,
        navigateAway: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      print("resumed after $seconds seconds.");
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
                        message: "Remove this user from group",
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
    type,
    message,
    navigateAway,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                type == 'success' ? "Congratulations!" : "Sorry!",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: type == 'success' ? Colors.green : Colors.red,
                ),
              ),
              Container(height: 10.0),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Colors.white,
                ),
              ),
              Container(height: 10.0),
              Text(
                "Keep Pauzing!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Colors.yellowAccent,
                ),
              ),
              Container(height: 10.0),
              Text(
                "#DefeatedThePhone",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.titilliumWebRegular,
                  color: Colors.cyanAccent,
                ),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              color: type == 'success' ? Colors.green : Colors.red,
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

  onSuccess(duration) async {
    final TimerBloc timerBloc = Provider.of<TimerBloc>(context);

    await timerBloc.setTimer(duration);

    String pointer = points[durationStatic] > 1 ? 'points' : 'point';
    String message = "You have won ${points[durationStatic]} $pointer.";

    showTimerPop(
      context,
      type: 'success',
      message: message,
      navigateAway: () {
        Navigator.of(context).pop();
      },
    );
  }
}
