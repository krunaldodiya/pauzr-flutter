import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
import 'package:pauzr/src/blocs/group/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class CreateGroupPage extends StatefulWidget {
  CreateGroupPage({Key key}) : super(key: key);

  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
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
          "Create Group",
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
              "Create".toUpperCase(),
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
          BlocBuilder(
            bloc: groupBloc,
            builder: (context, GroupState state) {
              return EditableFormField(
                maxLength: 50,
                textColor: Colors.black,
                borderColor: Colors.black,
                labelColor: Colors.black,
                controller: nameController,
                labelText: "Group Name",
                errorText: getErrorText(state.error, 'name'),
              );
            },
          ),
        ],
      ),
    );
  }

  void createGroup() {
    XsProgressHud.show(context);

    groupBloc.createGroup(nameController.text, (group) {
      XsProgressHud.hide();

      if (group != false) {
        return Navigator.pushReplacementNamed(
          context,
          routeList.add_group_participants,
          arguments: {"group": group},
        );
      }
    });
  }
}
