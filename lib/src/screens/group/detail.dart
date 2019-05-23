import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class GroupDetailPage extends StatefulWidget {
  final group;
  GroupDetailPage({Key key, @required this.group}) : super(key: key);

  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Group Detail",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text("Detail page"),
        ),
      ),
    );
  }
}
