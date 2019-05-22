import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: SizedBox(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.pushNamed(context, routeList.create_group);
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

    return ListView.separated(
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
          trailing: Icon(Icons.more_vert),
        );
      },
    );
  }
}
