import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/tabs/switch.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class ScoreboardPage extends StatefulWidget {
  ScoreboardPage({Key key}) : super(key: key);

  @override
  _ScoreboardPage createState() => _ScoreboardPage();
}

class _ScoreboardPage extends State<ScoreboardPage>
    with SingleTickerProviderStateMixin {
  UserBloc userBloc;

  String period = "Today";

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.mainScoreboard.backgroundColor,
      body: SwipeDetector(
        swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 100.0,
          verticalSwipeMinDisplacement: 50.0,
          verticalSwipeMaxWidthThreshold: 100.0,
          horizontalSwipeMaxHeightThreshold: 50.0,
          horizontalSwipeMinDisplacement: 50.0,
          horizontalSwipeMinVelocity: 200.0,
        ),
        onSwipeLeft: () {
          if (period == "Today") {
            setState(() {
              period = "This Week";
            });
          } else if (period == "This Week") {
            setState(() {
              period = "This Month";
            });
          }
        },
        onSwipeRight: () {
          if (period == "This Month") {
            setState(() {
              period = "This Week";
            });
          } else if (period == "This Week") {
            setState(() {
              period = "Today";
            });
          }
        },
        child: FutureBuilder(
          future: ApiProvider().getRankings(period),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final Response response = snapshot.data;
            final results = response.data;

            return BlocBuilder(
              bloc: userBloc,
              builder: (context, UserState state) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          getSwitch(
                            items: ["Today", "This Week", "This Month"],
                            selected: period,
                            onSelect: (index, value) {
                              setState(() {
                                period = value;
                              });
                            },
                            theme: theme,
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            child: getCards(results, theme),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              "City: ${state.user.location.city}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontFamily: Fonts.titilliumWebRegular,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        getList(state.user, results),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  getCards(results, theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.minutes);
            },
            child: BlocBuilder(
              bloc: userBloc,
              builder: (context, UserState state) {
                return getCard(
                  results['minutes_saved'].toString(),
                  "Minutes Saved",
                  theme,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.points);
            },
            child: BlocBuilder(
              bloc: userBloc,
              builder: (context, UserState state) {
                return getCard(
                  results['points_earned'].toString(),
                  "Points Earned",
                  theme,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.levels);
            },
            child: BlocBuilder(
              bloc: userBloc,
              builder: (context, UserState state) {
                return getCard(
                    "${state.user.level}/10", "Levels Cleared", theme);
              },
            ),
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
              color: theme.mainScoreboard.cardBackground,
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

  getList(user, results) {
    List<Widget> list = [];
    List rankings = results['rankings'];
    List rankingsFiltered = [];
    Map authUserRanking;

    rankings
      ..sort((a, b) => b['duration'].compareTo(a['duration']))
      ..asMap().forEach((index, ranking) {
        ranking['rank'] = index + 1;
        rankingsFiltered.add(ranking);

        if (ranking['user']['id'] == user.id) {
          authUserRanking = ranking;
        }
      });

    list.add(getRankCard(authUserRanking));

    list.add(
      Container(
        height: 0.5,
        color: Colors.black87,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      ),
    );

    rankings.forEach((ranking) {
      list.add(getRankCard(ranking));
    });

    return list;
  }

  Card getRankCard(Map ranking) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              "$baseUrl/users/${ranking['user']['avatar']}",
            ),
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              ranking['user']['name'].toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
          subtitle: Container(
            child: Row(
              children: <Widget>[
                Text(
                  "Rank: ${ranking['rank']}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
                Container(
                  width: 20,
                  alignment: Alignment.center,
                  child: Text("|"),
                ),
                Text(
                  "Level: ${ranking['user']['level']}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            child: Column(
              children: <Widget>[
                Text(
                  ranking['duration'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 22.0,
                    fontFamily: Fonts.titilliumWebSemiBold,
                  ),
                ),
                Text(
                  "Minutes",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
