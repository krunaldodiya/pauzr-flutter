import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGroupParticipantsPage extends StatefulWidget {
  final group;
  AddGroupParticipantsPage({Key key, this.group}) : super(key: key);

  _AddGroupParticipantsPageState createState() =>
      _AddGroupParticipantsPageState();
}

class _AddGroupParticipantsPageState extends State<AddGroupParticipantsPage> {
  List _participants = [];
  List _contacts = [];
  GroupBloc groupBloc;
  bool loading;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadContacts();

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
      body: loading == true
          ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Please wait, fetching contacts...",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: Fonts.titilliumWebSemiBold,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                Map contact = _contacts?.elementAt(index);

                return Container(
                  color: exists(contact) ? Colors.grey.shade200 : Colors.white,
                  child: ListTile(
                    onTap: () => toggleContact(contact),
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        "$baseUrl/users/${contact['avatar']}",
                      ),
                    ),
                    title: Text(
                      contact['name'].toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: Fonts.titilliumWebSemiBold,
                      ),
                    ),
                    subtitle: Text(
                      contact['mobile'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: Fonts.titilliumWebRegular,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void createGroup() {
    groupBloc.addParticipants(widget.group['id'], _participants, (data) {
      if (data.runtimeType != DioError) {
        Navigator.pop(context);
      }
    });
  }

  loadContacts() async {
    setState(() {
      loading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String contactsData = prefs.getString("contacts");

    if (contactsData != null) {
      setState(() {
        _contacts = json.decode(contactsData);
        loading = false;
      });
    }

    if (contactsData == null) {
      try {
        var contacts = await refreshContacts();

        setState(() {
          _contacts = contacts;
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  exists(contact) {
    return _participants.contains(contact['id']);
  }

  toggleContact(contact) {
    setState(() {
      if (exists(contact)) {
        _participants.remove(contact['id']);
      } else {
        _participants.add(contact['id']);
      }
    });
  }

  refreshContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();

    if (permissionStatus != PermissionStatus.granted) {
      return _handleInvalidPermissions(permissionStatus);
    }

    try {
      var contacts = await ContactsService.getContacts();

      var contactList = contacts
          .where((contact) => contact.phones.length > 0)
          .map((contact) => contact.toMap())
          .toList();

      Response response = await ApiProvider().syncContacts(contactList);
      var results = response.data['users'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("contacts", json.encode(results));

      return results;
    } catch (error) {
      ApiProvider().notifyError(error.response.data);
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
    }

    return permission;
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
        code: "PERMISSION_DENIED",
        message: "Access to location data denied",
        details: null,
      );
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
        code: "PERMISSION_DISABLED",
        message: "Location data is not available on device",
        details: null,
      );
    }
  }
}
