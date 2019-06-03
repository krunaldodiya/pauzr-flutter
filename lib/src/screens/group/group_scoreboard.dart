import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/rankings.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/group.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class GroupScoreboardPage extends StatefulWidget {
  final Group group;
  GroupScoreboardPage({Key key, @required this.group}) : super(key: key);

  @override
  _GroupScoreboardPage createState() => _GroupScoreboardPage();
}

class _GroupScoreboardPage extends State<GroupScoreboardPage>
    with SingleTickerProviderStateMixin {
  String period = "Today";

  List choices = [];

  @override
  void initState() {
    super.initState();

    choices.add("Group Info");

    getInitialData();
  }

  getInitialData() {
    Future.delayed(Duration(seconds: 1), () {
      final UserBloc userBloc = Provider.of<UserBloc>(context);

      if (userBloc.user.id == widget.group.ownerId) {
        choices.add("Edit Group");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.groupScoreboard.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.groupScoreboard.appBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeList.group_detail,
              arguments: {
                "group": widget.group,
              },
            );
          },
          child: Container(
            alignment: Alignment.center,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              isThreeLine: true,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  "$baseUrl/users/${widget.group.photo}",
                ),
              ),
              title: Text(
                widget.group.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebSemiBold,
                ),
              ),
              subtitle: Text(
                widget.group.description ?? "No description",
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            padding: EdgeInsets.all(0),
            onSelected: choiceActions,
            itemBuilder: (context) {
              return choices.map((choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SwipeDetector(
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
        child: FutureBuilder(
          future: ApiProvider().getRankings(period, widget.group.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final Response response = snapshot.data;
            final results = response.data;

            return CustomScrollView(
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
                        theme: theme,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    Ranking(user: userBloc.user, results: results).getList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  choiceActions(choice) {
    if (choice == "Group Info") {
      Navigator.pushNamed(
        context,
        routeList.group_detail,
        arguments: {
          "group": widget.group,
        },
      );
    }

    if (choice == "Edit Group") {
      Navigator.pushNamed(
        context,
        routeList.manage_group,
        arguments: {
          "group": widget.group,
        },
      );
    }
  }
}
