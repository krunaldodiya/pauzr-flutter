import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:waveprogressbar_flutter/waveprogressbar_flutter.dart';

class StopPage extends StatefulWidget {
  final int duration;

  StopPage({Key key, @required this.duration}) : super(key: key);

  @override
  _StopPage createState() =>
      _StopPage(durationStatic: duration, durationDynamic: duration);
}

class _StopPage extends State<StopPage> with SingleTickerProviderStateMixin {
  int durationStatic;
  int durationDynamic;

  _StopPage({this.durationStatic, this.durationDynamic});

  double waterHeight = 0.9;
  double rotation = 360;

  WaterController waterController = WaterController();

  @override
  void initState() {
    super.initState();

    double tick = waterHeight / durationStatic;

    WidgetsBinding widgetsBinding = WidgetsBinding.instance;

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        rotation = rotation > 0 ? rotation - 1 : 360;
      });
    });

    widgetsBinding.addPostFrameCallback((callback) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (durationDynamic > 0) {
          setState(() {
            durationDynamic--;
            waterController.changeWaterHeight(durationDynamic * tick);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop(context, () {
          print("cancelled");
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                          color: Colors.red,
                        ),
                      ),
                      WaveProgressBar(
                        flowSpeed: 0.1,
                        waveDistance: 45.0,
                        waveHeight: 18.0,
                        waterColor: Colors.blueAccent,
                        strokeCircleColor: Colors.blue,
                        circleStrokeWidth: 2.0,
                        heightController: waterController,
                        percentage: waterHeight,
                        size: Size(220, 220),
                        textStyle: TextStyle(fontSize: 0.0),
                      ),
                      Text(
                        getTimer(),
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontFamily: Fonts.digital7,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      return shouldPop(context, () {
                        return Navigator.of(context).pop();
                      });
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 55.0,
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

  Future<bool> shouldPop(BuildContext context, navigateAway) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure want to cancel ?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white),
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

  String getTimer() {
    int seconds = durationDynamic % 60;
    int minutes = durationDynamic ~/ 60;

    String sec = seconds > 9 ? "$seconds" : "0$seconds";
    String min = minutes > 9 ? "$minutes" : "0$minutes";

    return "$min : $sec";
  }
}
