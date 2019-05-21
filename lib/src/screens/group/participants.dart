import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
// import 'package:pauzr/src/blocs/group/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
// import 'package:pauzr/src/helpers/validation.dart';
// import 'package:pauzr/src/routes/list.dart' as routeList;
// import 'package:pauzr/src/screens/users/editable.dart';
// import 'package:xs_progress_hud/xs_progress_hud.dart';

class AddGroupParticipantsPage extends StatefulWidget {
  final group;
  AddGroupParticipantsPage({Key key, this.group}) : super(key: key);

  _AddGroupParticipantsPageState createState() =>
      _AddGroupParticipantsPageState();
}

class _AddGroupParticipantsPageState extends State<AddGroupParticipantsPage> {
  GroupBloc groupBloc;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      groupBloc = BlocProvider.of<GroupBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Add Participants",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: createGroup,
            child: Text(
              "Submit".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Text("hello"),
        ],
      ),
    );
  }

  void createGroup() {
    Navigator.pop(context);
  }
}
