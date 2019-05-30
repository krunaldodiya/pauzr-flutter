import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeBloc themeBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      themeBloc = Provider.of<ThemeBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.home.backgroundColor,
      floatingActionButton: SizedBox(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.pushNamed(
              context,
              routeList.manage_group,
              arguments: {"group": null},
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32.0,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiProvider().getGroups(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return createListView(context, snapshot);
          },
        ),
      ),
    );
  }

  Widget createListView(context, snapshot) {
    final Response response = snapshot.data;
    final results = response.data;
    final List groups = results['groups'];

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
              final group = groups[index]['group'];
              final subscribers = groups[index]['group']['subscribers'].length;

              return ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    routeList.scoreboard,
                    arguments: {"group": group},
                  );
                },
                isThreeLine: false,
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                    "$baseUrl/users/${group['photo']}",
                  ),
                ),
                title: Text(group['name']),
                subtitle: Text(
                  "${subscribers.toString()} participants.",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
