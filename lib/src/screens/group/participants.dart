import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
// import 'package:pauzr/src/blocs/group/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
// import 'package:pauzr/src/helpers/validation.dart';
// import 'package:pauzr/src/routes/list.dart' as routeList;
// import 'package:pauzr/src/screens/users/editable.dart';
// import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AddGroupParticipantsPage extends StatefulWidget {
  final group;
  AddGroupParticipantsPage({Key key, this.group}) : super(key: key);

  _AddGroupParticipantsPageState createState() =>
      _AddGroupParticipantsPageState();
}

class _AddGroupParticipantsPageState extends State<AddGroupParticipantsPage> {
  Iterable<Contact> _contacts;
  GroupBloc groupBloc;
  bool loading;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    refreshContacts();

    setState(() {
      groupBloc = BlocProvider.of<GroupBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(loading);

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
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts?.elementAt(index);

                return ListTile(
                  onTap: () {
                    //
                  },
                  leading: (contact.avatar != null && contact.avatar.length > 0)
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(contact.avatar))
                      : CircleAvatar(child: Text(contact.initials())),
                  title: Text(contact.displayName ?? contact.identifier),
                );
              },
            ),
    );
  }

  void createGroup() {
    Navigator.pop(context);
  }

  refreshContacts() async {
    setState(() {
      loading = true;
    });

    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts();

      setState(() {
        _contacts = contacts;
        loading = false;
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
      setState(() {
        loading = false;
      });
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}
