import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_winners.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/lottery.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
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
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);

    lotteryBloc.setLotteries(60);
    lotteryBloc.getLotteryWinners();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.mainScoreboard.backgroundColor,
      floatingActionButton: SizedBox(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          backgroundColor: Color(0xffFFD700),
          onPressed: () {
            Navigator.pushNamed(context, routeList.lottery);
          },
          child: Icon(
            Ionicons.ios_gift,
            color: Color(0xff0D62A2),
            // color: theme.home.fabIconColor,
            size: 24.0,
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
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
              lotteryWinners: lotteryBloc.lotteryWinners,
            ).getList(context),
          ),
        ),
      ],
    );
  }
}
