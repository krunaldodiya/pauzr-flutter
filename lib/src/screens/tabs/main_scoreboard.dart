import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/rankings.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/helpers/cards.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class MainScoreboardPage extends StatefulWidget {
  MainScoreboardPage({Key key}) : super(key: key);

  @override
  _MainScoreboardPage createState() => _MainScoreboardPage();
}

class _MainScoreboardPage extends State<MainScoreboardPage>
    with SingleTickerProviderStateMixin {
  String period = "Today";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

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
                        child: getCards(results, userBloc, theme),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(
                          "City: ${userBloc.user.location.city}",
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
                    Ranking(user: userBloc.user, results: results).getList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  getCards(results, UserBloc userBloc, DefaultTheme theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.minutes);
            },
            child: getCard(
              results['minutes_saved'].toString(),
              "Minutes Saved",
              80.0,
              40.0,
              theme.mainScoreboard,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.points);
            },
            child: getCard(
              results['points_earned'].toString(),
              "Points Earned",
              80.0,
              40.0,
              theme.mainScoreboard,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.levels);
            },
            child: getCard(
              "${userBloc.user.level}/10",
              "Levels Cleared",
              80.0,
              40.0,
              theme.mainScoreboard,
            ),
          ),
        ),
      ],
    );
  }
}
