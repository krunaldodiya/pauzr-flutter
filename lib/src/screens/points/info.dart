import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:provider/provider.dart';

class PointsPage extends StatefulWidget {
  PointsPage({Key key}) : super(key: key);

  @override
  _PointsPage createState() => _PointsPage();
}

class _PointsPage extends State<PointsPage>
    with SingleTickerProviderStateMixin {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.points.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.points.appBackgroundColor,
        title: Text(
          "Points".toUpperCase(),
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
          future: ApiProvider().getEarnedPoints(),
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

  getCards(body, theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState state) {
              return getCard(body['sum'].toString(), "All Time Saving", theme);
            },
          ),
        ),
        Expanded(
          child: BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState state) {
              return getCard(body['avg'].toString(), "Average per day", theme);
            },
          ),
        ),
      ],
    );
  }

  Card getCard(String title, String msg, DefaultTheme theme) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.gradientColor.color1,
                  theme.gradientColor.color2,
                ],
              ),
            ),
            height: 90.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 36.0,
                  fontFamily: Fonts.titilliumWebBold,
                ),
              ),
            ),
          ),
          Container(
            width: 80.0,
            padding: EdgeInsets.all(5.0),
            color: Colors.white,
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  createListView(context, snapshot, theme) {
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
              return getRankCard(item);
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
            MaterialCommunityIcons.coin,
            size: 42.0,
            color: Colors.green,
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              "${item['amount']} Points",
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
              "${item['created_at']}",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
