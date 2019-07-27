import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/lottery.dart';
import 'package:pauzr/src/providers/lottery.dart';
import 'package:pauzr/src/providers/user.dart';

class GetEarnings {
  final LotteryBloc lotteryBloc;
  final UserBloc userBloc;

  GetEarnings({@required this.userBloc, @required this.lotteryBloc});

  getList(context) {
    List<Widget> list = [];

    lotteryBloc.lotteryHistory.forEach((lotteryHistory) {
      list.add(getHistoryCard(lotteryHistory, context));
    });

    return list;
  }

  Card getHistoryCard(Lottery lotteryHistory, BuildContext context) {
    DateTime now = DateTime.parse(lotteryHistory.createdAt);

    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);

    return Card(
      shape: Border.all(color: Colors.transparent, width: 1.0),
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Text(
            "₹${lotteryHistory.amount.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 16.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
          title: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      child: Text(
                        lotteryHistory.type == "credited"
                            ? "Won Lottery"
                            : "Amount Withdraw",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          subtitle: Text(
            "${lotteryHistory.type} | ${lotteryHistory.status}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 12.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
          trailing: Container(
            child: Column(
              children: <Widget>[
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: Fonts.titilliumWebSemiBold,
                  ),
                ),
                Text(
                  formattedTime,
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
