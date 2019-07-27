import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_earnings.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/lottery.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';

class EarningsPage extends StatefulWidget {
  EarningsPage({Key key}) : super(key: key);

  @override
  _EarningsPage createState() => _EarningsPage();
}

class _EarningsPage extends State<EarningsPage>
    with SingleTickerProviderStateMixin {
  String period;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);

    lotteryBloc.getLotteryHistory();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.mainScoreboard.backgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xff0D62A2),
        title: Text(
          "Earnings",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      ),
      body: SafeArea(
        child: lotteryBloc.loaded != true
            ? Center(child: CircularProgressIndicator())
            : getWinnersList(lotteryBloc, theme, userBloc),
      ),
    );
  }

  getWinnersList(
    LotteryBloc lotteryBloc,
    DefaultTheme theme,
    UserBloc userBloc,
  ) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 5.0),
          color: Colors.white,
          width: double.infinity,
          child: Text(
            "Balance: ${lotteryBloc.total}",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
              color: Colors.black,
              fontFamily: Fonts.titilliumWebSemiBold,
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  GetEarnings(
                    userBloc: userBloc,
                    lotteryBloc: lotteryBloc,
                  ).getList(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
