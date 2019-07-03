import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/ranking.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

class GetRanking {
  final List<Ranking> rankings;
  final User user;

  GetRanking({@required this.user, @required this.rankings});

  getList(context) {
    List<Widget> list = [];

    rankings.forEach((ranking) {
      if (ranking.user.id == user.id) {
        list.add(getRankCard(ranking, context));
      }
    });

    list.add(
      Container(
        height: 0.5,
        color: Colors.black87,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      ),
    );

    rankings.forEach((ranking) {
      list.add(getRankCard(ranking, context));
    });

    return list;
  }

  Card getRankCard(Ranking ranking, BuildContext context) {
    return Card(
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
                "user": ranking.user,
              },
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: CachedNetworkImageProvider(
                "$baseUrl/storage/${ranking.user.avatar}",
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Text(
                ranking.user.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
            subtitle: Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "Rank: ${ranking.rank.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                  Container(
                    width: 20,
                    alignment: Alignment.center,
                    child: Text("|"),
                  ),
                  Text(
                    "Level: ${ranking.user.level.level}",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    ranking.duration.toString(),
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
}
