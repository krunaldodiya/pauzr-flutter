import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/tabs/switch.dart';
import 'package:swipedetector/swipedetector.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({Key key}) : super(key: key);

  @override
  _LeaderboardPage createState() => _LeaderboardPage();
}

class _LeaderboardPage extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  UserBloc userBloc;

  String period = "Today";
  String profession = "My Profession";

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      swipeConfiguration: SwipeConfiguration(
        verticalSwipeMinVelocity: 100.0,
        verticalSwipeMinDisplacement: 50.0,
        verticalSwipeMaxWidthThreshold: 100.0,
        horizontalSwipeMaxHeightThreshold: 50.0,
        horizontalSwipeMinDisplacement: 50.0,
        horizontalSwipeMinVelocity: 200.0,
      ),
      onSwipeLeft: () {
        if (period == "Today") {
          setState(() {
            period = "This Week";
          });
        } else if (period == "This Week") {
          setState(() {
            period = "This Month";
          });
        }
      },
      onSwipeRight: () {
        if (period == "This Month") {
          setState(() {
            period = "This Week";
          });
        } else if (period == "This Week") {
          setState(() {
            period = "Today";
          });
        }
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                getSwitch(
                  items: ["Today", "This Week", "This Month"],
                  selected: period,
                  onSelect: (index, value) {
                    setState(() {
                      period = value;
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: getCards(),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: getLocation(),
                ),
                getSwitch(
                  items: ["My Profession", "All Profession"],
                  selected: profession,
                  onSelect: (index, value) {
                    setState(() {
                      profession = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(getList()),
          ),
        ],
      ),
    );
  }

  getCards() {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.level);
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.green, Colors.blue],
                      ),
                    ),
                    height: 90.0,
                    child: Center(
                      child: Text(
                        "180",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 36.0,
                          fontFamily: Fonts.titilliumWebBold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    padding: EdgeInsets.all(5.0),
                    color: Colors.white,
                    child: Text(
                      "Minutes Saved",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: Fonts.titilliumWebSemiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.level);
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.green, Colors.blue],
                      ),
                    ),
                    height: 90.0,
                    child: Center(
                      child: Text(
                        "13",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 36.0,
                          fontFamily: Fonts.titilliumWebBold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    padding: EdgeInsets.all(5.0),
                    color: Colors.white,
                    child: Text(
                      "Points Earned",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: Fonts.titilliumWebSemiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, routeList.level);
            },
            child: BlocBuilder(
                bloc: userBloc,
                builder: (context, UserState state) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.green, Colors.blue],
                            ),
                          ),
                          height: 90.0,
                          child: Center(
                            child: Text(
                              "${state.user.level}/10",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 36.0,
                                fontFamily: Fonts.titilliumWebBold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 80.0,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.white,
                          child: Text(
                            "Levels Cleared",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: Fonts.titilliumWebSemiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  getLocation() {
    return Text(
      "City: Ahmedabad",
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        fontFamily: Fonts.titilliumWebRegular,
      ),
    );
  }

  getList() {
    List<Widget> list = [];

    list.add(getRankCard(545));

    list.add(
      Container(
        height: 0.5,
        color: Colors.black87,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      ),
    );

    for (var i = 0; i < 10; i++) {
      final int rank = i + 1;

      list.add(getRankCard(rank));
    }

    return list;
  }

  Card getRankCard(int rank) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          border: rank == 545
              ? Border.all(
                  color: Colors.black,
                  width: 0.5,
                )
              : null,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              "https://cdn.iconscout.com/icon/free/png-256/avatar-372-456324.png",
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
          subtitle: Container(
            child: Row(
              children: <Widget>[
                Text(
                  "Rank: $rank",
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
                  "Level: 5",
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
                  "300",
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
