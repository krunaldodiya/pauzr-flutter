import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/models/winners.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

class GetWinners {
  final List<Winner> winners;
  final User user;

  GetWinners({@required this.user, @required this.winners});

  getList(context) {
    List<Widget> list = [];

    winners.forEach((winner) {
      list.add(getRankCard(winner, context));
    });

    return list;
  }

  Card getRankCard(Winner winner, BuildContext context) {
    Color primaryColor = getPrimaryColor(winner);

    return Card(
      shape: Border.all(color: primaryColor, width: 1.0),
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
                "user": winner.user,
              },
            );
          },
          child: ListTile(
            leading: ClipOval(
              child: Image.network(
                "$baseUrl/storage/${winner.user.avatar}",
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
                    winner.user.name.toUpperCase(),
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
                          "RANK: ${winner.rank.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                      ),
                      if (winner.rank <= 3)
                        Container(
                          child: Text(
                            "👑",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 16.0,
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
              winner.user.city.name,
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
                    winner.duration.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 22.0,
                      fontFamily: Fonts.titilliumWebSemiBold,
                    ),
                  ),
                  Text(
                    "Minutes",
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

  Color getPrimaryColor(Winner winner) {
    if (winner.rank <= 3) {
      return Colors.amber;
    }

    return Colors.transparent;
  }
}
