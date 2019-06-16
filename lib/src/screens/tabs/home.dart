import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/group.dart';
import 'package:pauzr/src/models/group_subscription.dart';
import 'package:pauzr/src/providers/group.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);
    groupBloc.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.home.backgroundColor,
      floatingActionButton: SizedBox(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          backgroundColor: theme.home.fabBackgroundColor,
          onPressed: () {
            Navigator.pushNamed(
              context,
              routeList.manage_group,
              arguments: {"group": null},
            );
          },
          child: Icon(
            Icons.add,
            color: theme.home.fabIconColor,
            size: 32.0,
          ),
        ),
      ),
      body: SafeArea(
        child: groupBloc.loading != false
            ? Center(child: CircularProgressIndicator())
            : createListView(context, groupBloc.groups),
      ),
    );
  }

  Widget createListView(context, groups) {
    if (groups.length == 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Text(
          "No groups yet.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            "Groups (${groups.length})",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 18.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                height: 0,
                indent: 0,
              );
            },
            itemCount: groups.length,
            itemBuilder: (context, int index) {
              final Group group = groups[index];
              final List<GroupSubscription> subscriptions = group.subscriptions;

              final date = DateTime.parse(group.createdAt);
              String formattedDate = DateFormat('dd-MM-yyyy').format(date);

              return ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    routeList.group_scoreboard,
                    arguments: {"group": group},
                  );
                },
                isThreeLine: false,
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: CachedNetworkImageProvider(
                    "$baseUrl/storage/${group.photo}",
                  ),
                ),
                title: Text(group.name),
                subtitle: Text(
                  "${subscriptions.length} participants.",
                ),
                trailing: Column(
                  children: <Widget>[
                    Text(
                      "Created on",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14.0,
                        fontFamily: Fonts.titilliumWebRegular,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 12.0,
                        fontFamily: Fonts.titilliumWebRegular,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
