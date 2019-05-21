import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/screens/users/editable.dart';

class CreateGroupPage extends StatefulWidget {
  CreateGroupPage({Key key}) : super(key: key);

  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  UserBloc userBloc;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
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
            onPressed: () {
              print(nameController.text);
            },
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
          EditableFormField(
            maxLength: 50,
            textColor: Colors.black,
            borderColor: Colors.black,
            labelColor: Colors.black,
            controller: nameController,
            labelText: "Group Name",
            errorText: getErrorText(null, 'name'),
          ),
        ],
      ),
    );
  }
}
