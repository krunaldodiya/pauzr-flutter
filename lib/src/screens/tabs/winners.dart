import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_winners.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/providers/ranking.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';

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

  getWinnersList(
    RankingBloc rankingBloc,
    DefaultTheme theme,
    UserBloc userBloc,
  ) {
    return CustomScrollView(
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
        periodSort = 'Week';
        break;

      default:
        periodSort = 'Week';
    }

    rankingBloc.getWinners(periodSort);
  }
}
