import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/cards.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:provider/provider.dart';

class MinutesPage extends StatefulWidget {
  MinutesPage({Key key}) : super(key: key);

  @override
  _MinutesPage createState() => _MinutesPage();
}

class _MinutesPage extends State<MinutesPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

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
        child: FutureBuilder(
          future: ApiProvider().getSavedMinutes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return createListView(context, snapshot, theme);
          },
        ),
      ),
    );
  }

  getCards(Map body, DefaultTheme theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: getCard(
            body['sum'].toString(),
            "All Time Saving",
            100.0,
            50.0,
            theme.minutes,
          ),
        ),
        Expanded(
          child: getCard(
            body['avg'].toString(),
            "Average per day",
            100.0,
            50.0,
            theme.minutes,
          ),
        ),
      ],
    );
  }

  createListView(context, snapshot, DefaultTheme theme) {
    final Response response = snapshot.data;
    final results = response.data;
    final List history = results['history'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          child: getCards(results, theme),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (context, int index) {
              final item = history[index];

              return Column(
                children: <Widget>[
                  if (showDateLabel(history, index))
                    Container(
                      child: Text(
                        separtedDateTime(item['created_at'], 'date'),
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

  Card getRankCard(Map item) {
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
              "${item['duration']} Minutes",
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
              "${separtedDateTime(item['created_at'], 'time')}",
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

  showDateLabel(history, index) {
    final previousIndex = index == 0 ? 0 : index - 1;
    final date = DateTime.parse(history[index]['created_at']);
    final previousDate = DateTime.parse(history[previousIndex]['created_at']);

    return index == 0 || date.day != previousDate.day;
  }
}
