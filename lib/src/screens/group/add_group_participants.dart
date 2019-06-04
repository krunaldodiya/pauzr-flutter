import 'package:flutter/material.dart';
import 'package:pauzr/src/models/group.dart';

class AddGroupParticipantsPage extends StatefulWidget {
  final Group group;

  AddGroupParticipantsPage({Key key, this.group}) : super(key: key);

  _AddGroupParticipantsPageState createState() =>
      _AddGroupParticipantsPageState();
}

class _AddGroupParticipantsPageState extends State<AddGroupParticipantsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("test"),
    );
  }
}
