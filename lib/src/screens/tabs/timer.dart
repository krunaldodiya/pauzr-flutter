import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/tabs/timer_cards.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  @override
  _TimerPage createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage> with SingleTickerProviderStateMixin {
  int currentQuote = 0;

  final List quotes = [
    {
      "id": "1",
      "author": "Dr.APJ Abdul Kalam",
      "title":
          "If you want to shine like a sun, first learn to burn like a sun.",
      "image": "assets/images/quotes/APJ-Abdul-Kalam.jpg"
    },
    {
      "id": "2",
      "author": "Swami Vivekananda",
      "title": "All power is within you, you can do anything and everything.",
      "image": "assets/images/quotes/Swami-Vivekananda.jpg"
    },
    {
      "id": "3",
      "author": "Jack Ma",
      "title":
          "If you don’t give up , you still have a chance. Giving up is the greatest failure.",
      "image": "assets/images/quotes/Jack-Ma.png"
    },
    {
      "id": "4",
      "author": "Barack Obama",
      "title": "Your voice can change the world",
      "image": "assets/images/quotes/Barack-Obama.jpg"
    },
    {
      "id": "5",
      "author": "Steve Jobs",
      "title": "Stay hungry. Stay foolish.",
      "image": "assets/images/quotes/Steve-Job.jpg"
    },
    {
      "id": "6",
      "author": "Elon Musk",
      "title":
          " When something is important enough, you do it even if odds are against your favor",
      "image": "assets/images/quotes/Elon-Musk.jpg"
    },
    {
      "id": "7",
      "author": "Ratan Tata",
      "title":
          "If you want to walk fast, walk alone. If you want to walk far, walk together",
      "image": "assets/images/quotes/Ratan-Tata.jpg"
    },
    {
      "id": "8",
      "author": "Bruce Lee",
      "title":
          "Knowing is not enough, we must apply. Willing is not enough, we must do.",
      "image": "assets/images/quotes/Bruce-Lee.jpg"
    },
    {
      "id": "9",
      "author": "Dalai Lama",
      "title": "World peace begins with inner peace",
      "image": "assets/images/quotes/Dalai-Lama.jpg"
    },
    {
      "id": "10",
      "author": "Abraham Lincoln",
      "title": "The best way to predict future is to create it.",
      "image": "assets/images/quotes/Abraham-Lincoln.jpg"
    },
    {
      "id": "11",
      "author": "Sachin Tendulkar",
      "title": "Don’t stop chasing your dreams, because dreams do come true",
      "image": "assets/images/quotes/Sachin-Tendulkar.jpg"
    },
    {
      "id": "12",
      "author": "Bill Gates",
      "title": "Patience is the key element of success.",
      "image": "assets/images/quotes/Bill-Gates.jpg"
    },
    {
      "id": "13",
      "author": "Mother Teresa",
      "title":
          "What can you do to promote world peace? Go home and love our family.",
      "image": "assets/images/quotes/Mother-Teresa.jpg"
    },
    {
      "id": "14",
      "author": "Dwayne 'The Rock' Johnson",
      "title": "There is a hidden blessing in every struggle.",
      "image": "assets/images/quotes/Dwayne-Johnson.jpg"
    }
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        this.currentQuote = this.currentQuote < 4 ? this.currentQuote + 1 : 0;
      });
    });
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
