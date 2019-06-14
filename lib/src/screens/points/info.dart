import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/cards.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/wallet_transaction.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/wallet.dart';
import 'package:provider/provider.dart';

class PointsPage extends StatefulWidget {
  PointsPage({Key key}) : super(key: key);

  @override
  _PointsPage createState() => _PointsPage();
}

class _PointsPage extends State<PointsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final WalletBloc walletBloc = Provider.of<WalletBloc>(context);
    walletBloc.getWalletHistory();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final WalletBloc walletBloc = Provider.of<WalletBloc>(context);

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
        child: walletBloc.loaded == false
            ? Center(child: CircularProgressIndicator())
            : createListView(context, walletBloc, theme),
      ),
    );
  }

  createListView(context, WalletBloc walletBloc, theme) {
    final List<WalletTransaction> walletHistory = walletBloc.walletHistory;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          child: getCards(walletBloc, theme),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: walletHistory.length,
            itemBuilder: (context, int index) {
              final WalletTransaction item = walletHistory[index];

              return Column(
                children: <Widget>[
                  if (showDateLabel(walletHistory, index))
                    Container(
                      child: Text(
                        separtedDateTime(item.createdAt, 'date'),
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

  getCards(WalletBloc walletBloc, DefaultTheme theme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: getCard(
            walletBloc.sum.toString(),
            null,
            "All Time Earnings",
            100.0,
            50.0,
            theme.points,
          ),
        ),
        Expanded(
          child: getCard(
            walletBloc.avg.toString(),
            null,
            "Average per day",
            100.0,
            50.0,
            theme.points,
          ),
        ),
      ],
    );
  }

  Card getRankCard(WalletTransaction item) {
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
              "${item.amount} Points",
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
              "${separtedDateTime(item.createdAt, 'time')}",
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

  showDateLabel(List<WalletTransaction> walletHistory, int index) {
    final currentHistory = walletHistory[index];
    final previousHistory =
        index > 0 ? walletHistory[index - 1] : currentHistory;

    final currentWalletHistoryDate = DateTime.parse(currentHistory.createdAt);
    final previousWalletHistoryDate = DateTime.parse(previousHistory.createdAt);

    return index == 0 ||
        currentWalletHistoryDate.day != previousWalletHistoryDate.day;
  }
}
