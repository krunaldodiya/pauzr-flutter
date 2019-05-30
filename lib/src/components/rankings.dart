import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';

class Ranking {
  final Map results;
  final User user;

  Ranking({@required this.user, @required this.results});

  getList() {
    List<Widget> list = [];
    List rankings = results['rankings'];
    List rankingsFiltered = [];
    Map authUserRanking;

    rankings
      ..sort((a, b) => b['duration'].compareTo(a['duration']))
      ..asMap().forEach((index, ranking) {
        ranking['rank'] = index + 1;
        rankingsFiltered.add(ranking);

        if (ranking['user']['id'] == user.id) {
          authUserRanking = ranking;
        }
      });

    list.add(getRankCard(authUserRanking));

    list.add(
      Container(
        height: 0.5,
        color: Colors.black87,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      ),
    );

    rankings.forEach((ranking) {
      list.add(getRankCard(ranking));
    });

    return list;
  }

  Card getRankCard(Map ranking) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              "$baseUrl/users/${ranking['user']['avatar']}",
            ),
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              ranking['user']['name'].toUpperCase(),
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
                  "Rank: ${ranking['rank']}",
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
                  "Level: ${ranking['user']['level']}",
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
                  ranking['duration'].toString(),
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
    );
  }
}
