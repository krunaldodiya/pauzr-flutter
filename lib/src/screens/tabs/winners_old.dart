import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_winners_old.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/swipe.dart';
import 'package:pauzr/src/providers/ranking.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class WinnersPage extends StatefulWidget {
  WinnersPage({Key key}) : super(key: key);

  @override
  _WinnersPage createState() => _WinnersPage();
}

class _WinnersPage extends State<WinnersPage>
    with SingleTickerProviderStateMixin {
  String period;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final RankingBloc rankingBloc = Provider.of<RankingBloc>(context);
    changePeriod("This Week", rankingBloc);
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
            : getWinnersList(rankingBloc, theme, userBloc),
      ),
    );
  }

  SwipeDetector getWinnersList(
    RankingBloc rankingBloc,
    DefaultTheme theme,
    UserBloc userBloc,
  ) {
    return SwipeDetector(
      swipeConfiguration: swipeConfiguration,
      onSwipeLeft: () {
        if (period == "This Week") {
          changePeriod("This Month", rankingBloc);
        }
      },
      onSwipeRight: () {
        if (period == "This Month") {
          changePeriod("This Week", rankingBloc);
        }
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                getSwitch(
                  items: ["This Week", "This Month"],
                  selected: period,
                  onSelect: (index, value) {
                    changePeriod(value, rankingBloc);
                  },
                  theme: theme,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    "Country: ${userBloc.user.country.name}",
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
              GetWinners(
                user: userBloc.user,
                winners: rankingBloc.winners,
              ).getList(context),
            ),
          ),
        ],
      ),
    );
  }

  void changePeriod(value, RankingBloc rankingBloc) {
    setState(() => period = value);

    String periodSort;

    switch (period) {
      case 'Today':
        periodSort = 'Today';
        break;

      case 'This Week':
        periodSort = 'Week';
        break;

      case 'This Month':
        periodSort = 'Month';
        break;

      default:
        periodSort = 'Week';
    }

    rankingBloc.getWinners(periodSort);
  }
}
