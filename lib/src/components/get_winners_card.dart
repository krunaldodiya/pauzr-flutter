import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/lottery.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

Card getRankCard(Lottery lotteryWinner, BuildContext context) {
  DateTime now = DateTime.parse(lotteryWinner.createdAt);

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
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeList.view_profile,
            arguments: {
              "shouldPop": true,
              "user": lotteryWinner.user,
            },
          );
        },
        child: ListTile(
          leading: ClipOval(
            child: Image.network(
              "$baseUrl/storage/${lotteryWinner.user.avatar}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          title: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  lotteryWinner.user.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "Won ₹${lotteryWinner.amount}",
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
            lotteryWinner.user.city.name,
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
    ),
  );
}
