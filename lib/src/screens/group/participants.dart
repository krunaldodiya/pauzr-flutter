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
  bool reloadContacts = false;
  String keywords;

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
    List filteredContact = _contacts.where((contact) {
      if (keywords != null) {
        var filterByName =
            contact['name'].toLowerCase().contains(keywords.toLowerCase());

        var filterByMobile =
            contact['mobile'].toLowerCase().contains(keywords.toLowerCase());

        var filterByDisplayName = contact['displayName']
            .toLowerCase()
            .contains(keywords.toLowerCase());

        return filterByName == true ||
            filterByMobile == true ||
            filterByDisplayName == true;
      }

      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Container(
          alignment: Alignment.center,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            isThreeLine: true,
            title: Text(
              "Add Participants",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
            subtitle: Text(
              "${_participants.length} of ${_contacts.length} selected",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
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
          : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, top: 5.0),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              keywords = text;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: "Filter by Name or Mobile",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.refresh,
                          size: 30.0,
                        ),
                        onPressed: () {
                          setState(() {
                            reloadContacts = true;
                          });

                          loadContacts();
                        },
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemCount: filteredContact.length,
                  itemBuilder: (context, index) {
                    Map contact = filteredContact?.elementAt(index);

                    return Container(
                      color:
                          exists(contact) ? Colors.green.shade50 : Colors.white,
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
                        trailing: exists(contact)
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                    );
                  },
                ),
              ],
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

  excludeContacts(List contacts) {
    List data = [];
    List subscribers = widget.group['subscribers'];
    List subscribersIds = subscribers.map((sub) => sub['id']).toList();

    contacts.forEach((contact) {
      if (subscribersIds.contains(contact['id']) == false) {
        data.add(contact);
      }
    });

    setState(() {
      _contacts = data;
      loading = false;
      reloadContacts = false;
    });
  }

  loadContacts() async {
    setState(() {
      loading = true;
    });

    if (reloadContacts == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String contactsData = prefs.getString("contacts");

      if (contactsData != null) {
        excludeContacts(json.decode(contactsData));
      } else {
        setState(() {
          reloadContacts = true;
        });
      }
    }

    if (reloadContacts == true) {
      try {
        var contacts = await refreshContacts();
        excludeContacts(json.decode(contacts));
      } catch (error) {
        setState(() {
          loading = false;
          reloadContacts = false;
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
      return [];
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
