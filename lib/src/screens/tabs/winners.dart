import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_winners_card.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/lottery.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final LotteryBloc lotteryBloc = Provider.of<LotteryBloc>(context);
    lotteryBloc.getLotteryWinners(reload: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        lotteryBloc.getLotteryWinners(reload: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
            : createListView(
                context,
                lotteryBloc,
                userBloc,
                _scrollController,
                theme,
              ),
      ),
    );
  }

  createListView(
    BuildContext context,
    LotteryBloc lotteryBloc,
    UserBloc userBloc,
    ScrollController scrollController,
    DefaultTheme theme,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: lotteryBloc.lotteryWinners.length,
            itemBuilder: (BuildContext context, int index) {
              final Lottery item = lotteryBloc.lotteryWinners[index];

              bool lastPage = lotteryBloc.page == lotteryBloc.lastPage;
              bool lastItem = index == lotteryBloc.lotteryWinners.length - 1;

              return Column(
                children: <Widget>[
                  getRankCard(item, context),
                  if (lastPage && lastItem)
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "No more results.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        if (lotteryBloc.busy)
          Container(
            margin: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "Loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
