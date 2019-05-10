import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/tabs/quotes.dart';
import 'package:pauzr/src/screens/tabs/timer_cards.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  @override
  _TimerPage createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage> with SingleTickerProviderStateMixin {
  int currentQuote = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black,
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
                image: AssetImage(
                  quotes[currentQuote]['image'],
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  width: double.infinity,
                  child: Text(
                    quotes[currentQuote]['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20.0, right: 20.0),
                  child: Text(
                    "- ${quotes[currentQuote]['author'].toUpperCase()}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lime,
                      fontWeight: FontWeight.normal,
                      fontFamily: Fonts.titilliumWebSemiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: Row(
              children: <Widget>[
                getTimerCard(20),
                getTimerCard(40),
                getTimerCard(60),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getTimerCard(time) {
    return Container(
      height: 130.0,
      width: MediaQuery.of(context).size.width / 3,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeList.stop, arguments: {
            "duration": time * 60,
          });
        },
        child: getCard(time.toString(), "Minutes"),
      ),
    );
  }
}
