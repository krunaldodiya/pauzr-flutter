import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/cards.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/timer.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/timer.dart';
import 'package:provider/provider.dart';

class MinutesPage extends StatefulWidget {
  MinutesPage({Key key}) : super(key: key);

  @override
  _MinutesPage createState() => _MinutesPage();
}

class _MinutesPage extends State<MinutesPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final TimerBloc timerBloc = Provider.of<TimerBloc>(context);
    timerBloc.getTimerHistory();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final TimerBloc timerBloc = Provider.of<TimerBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.minutes.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.minutes.appBackgroundColor,
        title: Text(
          "Minutes".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
      body: SafeArea(
        child: timerBloc.loaded == false
            ? Center(child: CircularProgressIndicator())
            : createListView(context, timerBloc, theme),
      ),
    );
  }

  createListView(context, TimerBloc timerBloc, DefaultTheme theme) {
    final List<Timer> timerHistory = timerBloc.timerHistory;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          child: getCards(timerBloc, theme),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: timerHistory.length,
            itemBuilder: (context, int index) {
              final Timer item = timerHistory[index];

              return Column(
                children: <Widget>[
                  if (showDateLabel(timerHistory, index))
                    Container(
                      child: Text(
                        separtedDateTime(item.createdAt, 'date'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                      margin: EdgeInsets.all(10.0),
                    ),
                  getRankCard(item),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  getCards(TimerBloc timerBloc, DefaultTheme theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: getCard(
            timerBloc.sum.toString(),
            null,
            "All Time Savings",
            100.0,
            50.0,
            theme.minutes,
          ),
        ),
        Expanded(
          child: getCard(
            timerBloc.avg.toString(),
            null,
            "Average per day",
            100.0,
            50.0,
            theme.minutes,
          ),
        ),
      ],
    );
  }

  Card getRankCard(Timer item) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Icon(
            Icons.timelapse,
            size: 42.0,
            color: Colors.green,
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              "${item.duration} Minutes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
          subtitle: Container(
            child: Text(
              "${separtedDateTime(item.createdAt, 'time')}",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
        ),
      ),
    );
  }

  separtedDateTime(dateTime, output) {
    final date = DateTime.parse(dateTime);

    final formatter = output == 'date' ? 'dd-MM-yyyy' : "hh:mm a";
    String formattedDob = DateFormat(formatter).format(date);

    return formattedDob;
  }

  showDateLabel(List<Timer> timerHistory, int index) {
    final currentHistory = timerHistory[index];
    final previousHistory =
        index > 0 ? timerHistory[index - 1] : currentHistory;

    final currentTimerHistoryDate = DateTime.parse(currentHistory.createdAt);
    final previousTimerHistoryDate = DateTime.parse(previousHistory.createdAt);

    return index == 0 ||
        currentTimerHistoryDate.day != previousTimerHistoryDate.day;
  }
}
