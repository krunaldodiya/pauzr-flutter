import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/components/get_rankings.dart';
import 'package:pauzr/src/components/switch.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/swipe.dart';
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

    if (groupBloc.loaded == true && group == null) {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Group $group does not exists.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      );
    }

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
                "group": group,
              },
            );
          },
          child: Container(
            alignment: Alignment.center,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              isThreeLine: true,
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: "$baseUrl/storage/${group.photo}",
                  placeholder: (context, url) {
                    return Image.asset(
                      "assets/images/loading.gif",
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error);
                  },
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
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
            : getRankersList(rankingBloc, theme, userBloc),
      ),
    );
  }

  SwipeDetector getRankersList(
    RankingBloc rankingBloc,
    DefaultTheme theme,
    UserBloc userBloc,
  ) {
    return SwipeDetector(
      swipeConfiguration: swipeConfiguration,
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
              ).getList(context),
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

  void changePeriod(String value, RankingBloc rankingBloc) {
    setState(() => period = value);
    rankingBloc.getRankings(period, null, widget.group.id);
  }
}
