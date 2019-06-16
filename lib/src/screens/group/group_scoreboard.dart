import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_rankings.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/group.dart';
import 'package:pauzr/src/providers/group.dart';
import 'package:pauzr/src/providers/ranking.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class GroupScoreboardPage extends StatefulWidget {
  final Group group;

  GroupScoreboardPage({
    Key key,
    @required this.group,
  }) : super(key: key);

  @override
  _GroupScoreboardPage createState() => _GroupScoreboardPage();
}

class _GroupScoreboardPage extends State<GroupScoreboardPage>
    with SingleTickerProviderStateMixin {
  String period;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final RankingBloc rankingBloc = Provider.of<RankingBloc>(context);
    changePeriod("Today", rankingBloc);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);
    final RankingBloc rankingBloc = Provider.of<RankingBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    final groupSelector =
        groupBloc.groups.where((group) => group.id == widget.group.id);

    final Group group = groupSelector.length > 0 ? groupSelector.first : null;

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
                "group": group != null ? group : widget.group,
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
                backgroundImage: CachedNetworkImageProvider(
                  "$baseUrl/storage/${group.photo}",
                ),
              ),
              title: Text(
                group.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebSemiBold,
                ),
              ),
              subtitle: Text(
                group.description ?? "No description",
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
              return getChoices(userBloc, group).map((choice) {
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
      body: SafeArea(
        child: rankingBloc.loaded != true
            ? Center(child: CircularProgressIndicator())
            : buildSwipeDetector(rankingBloc, theme, userBloc),
      ),
    );
  }

  SwipeDetector buildSwipeDetector(
      RankingBloc rankingBloc, DefaultTheme theme, UserBloc userBloc) {
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
          changePeriod("This Week", rankingBloc);
        } else if (period == "This Week") {
          changePeriod("This Month", rankingBloc);
        }
      },
      onSwipeRight: () {
        if (period == "This Month") {
          changePeriod("This Week", rankingBloc);
        } else if (period == "This Week") {
          changePeriod("Today", rankingBloc);
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
                    changePeriod(value, rankingBloc);
                  },
                  theme: theme,
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              GetRanking(
                user: userBloc.user,
                rankings: rankingBloc.rankings,
              ).getList(),
            ),
          ),
        ],
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

  List getChoices(userBloc, group) {
    List choices = [];

    choices.add("Group Info");

    if (userBloc.user.id == group.owner.id) {
      choices.add("Edit Group");
    }

    return choices;
  }

  void changePeriod(value, rankingBloc) {
    setState(() => period = value);
    rankingBloc.getRankings(period, widget.group.id);
  }
}
