import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_rankings.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/helpers/cards.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/ranking.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
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
  String period;
  String location = "city";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final RankingBloc rankingBloc = Provider.of<RankingBloc>(context);
    changePeriod("Today", rankingBloc);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final RankingBloc rankingBloc = Provider.of<RankingBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.mainScoreboard.backgroundColor,
      body: SafeArea(
        child: rankingBloc.loaded != true
            ? Center(child: CircularProgressIndicator())
            : buildSwipeDetector(rankingBloc, theme, userBloc),
      ),
    );
  }

  SwipeDetector buildSwipeDetector(
    RankingBloc rankingBloc,
    DefaultTheme theme,
    UserBloc userBloc,
  ) {
    return SwipeDetector(
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
          changePeriod("This Week", rankingBloc);
        } else if (period == "This Week") {
          changePeriod("This Month", rankingBloc);
        }
      },
      onSwipeRight: () {
        if (period == "This Month") {
          changePeriod("This Week", rankingBloc);
        } else if (period == "This Week") {
          changePeriod("Today", rankingBloc);
        }
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                getSwitch(
                  items: ["Today", "This Week", "This Month"],
                  selected: period,
                  onSelect: (index, value) {
                    changePeriod(value, rankingBloc);
                  },
                  theme: theme,
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: getCards(rankingBloc, userBloc, theme),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          String newLocation =
                              location == "city" ? "country" : "city";
                          changeLocation(newLocation, rankingBloc);
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              location.toUpperCase(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontFamily: Fonts.titilliumWebRegular,
                              ),
                            ),
                            Container(width: 5.0),
                            Icon(
                              Ionicons.md_arrow_dropdown_circle,
                              color: Colors.blue,
                              size: 20.0,
                            )
                          ],
                        ),
                      ),
                      Container(width: 10.0),
                      Text(
                        location == "city"
                            ? userBloc.user.city.name.toUpperCase()
                            : userBloc.user.country.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              GetRanking(
                user: userBloc.user,
                rankings: rankingBloc.rankings,
              ).getList(context),
            ),
          ),
        ],
      ),
    );
  }

  getCards(RankingBloc rankingBloc, UserBloc userBloc, DefaultTheme theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.minutes);
            },
            child: getCard(
              rankingBloc.minutesSaved.toString(),
              null,
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
              rankingBloc.pointsEarned.toString(),
              null,
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
              "${userBloc.user.level.level}/10",
              null,
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

  void changePeriod(value, RankingBloc rankingBloc) {
    setState(() => period = value);
    rankingBloc.getRankings(period, location, null);
  }

  void changeLocation(String value, RankingBloc rankingBloc) {
    setState(() => location = value);
    rankingBloc.getRankings(period, location, null);
  }
}
