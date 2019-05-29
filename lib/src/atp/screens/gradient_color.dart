import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GradientColor {
  Color switchBackground1;
  Color switchBackground2;
  Color timerCardBackground1;
  Color timerCardBackground2;
  Color mainScoreboardCardBackground1;
  Color mainScoreboardCardBackground2;
  Color minutesCardBackground1;
  Color minutesCardBackground2;
  Color pointsCardBackground1;
  Color pointsCardBackground2;

  GradientColor({
    @required this.switchBackground1,
    @required this.switchBackground2,
    @required this.timerCardBackground1,
    @required this.timerCardBackground2,
    @required this.mainScoreboardCardBackground1,
    @required this.mainScoreboardCardBackground2,
    @required this.minutesCardBackground1,
    @required this.minutesCardBackground2,
    @required this.pointsCardBackground1,
    @required this.pointsCardBackground2,
  });

  factory GradientColor.initial() {
    return GradientColor(
      switchBackground1: Colors.black,
      switchBackground2: Colors.black,
      timerCardBackground1: Colors.white,
      timerCardBackground2: Colors.white,
      mainScoreboardCardBackground1: Colors.white,
      mainScoreboardCardBackground2: Colors.white,
      minutesCardBackground1: Colors.white,
      minutesCardBackground2: Colors.white,
      pointsCardBackground1: Colors.white,
      pointsCardBackground2: Colors.white,
    );
  }
}
