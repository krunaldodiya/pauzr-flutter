import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({Key key}) : super(key: key);

  @override
  _LeaderboardPage createState() => _LeaderboardPage();
}

class _LeaderboardPage extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.only(top: 10.0),
                height: 60.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                      ),
                      child: Container(
                        width: 180.0,
                        color: Colors.cyanAccent,
                        child: Center(
                          child: Text(
                            "My Profession",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                      ),
                      child: Container(
                        width: 180.0,
                        color: Color(0xffffffff),
                        child: Center(
                          child: Text(
                            "All Profession",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Rank",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 18.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(
                          "#5",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                            fontSize: 18.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        color: Colors.lime,
                        child: Image.asset(
                          'assets/images/champ_level01.png',
                          width: 130.0,
                          height: 130.0,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Points",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 18.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(
                          "150",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                            fontSize: 18.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            "Daily",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: Text(
                            "Weekly",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: Text(
                            "Monthly",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 5.0)
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(getList()),
        ),
      ],
    );
  }

  getList() {
    List<Widget> list = [];

    for (var i = 0; i < 10; i++) {
      list.add(
        Card(
          elevation: 1.0,
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  "https://services.tegrazone.com/sites/default/files/app-icon/amazon-video_appicon2_0.png",
                ),
              ),
              title: Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Krunal Dodiya",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
              ),
              subtitle: Text(
                "#1",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 14.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
                softWrap: true,
              ),
            ),
          ),
        ),
      );
    }

    return list;
  }
}
