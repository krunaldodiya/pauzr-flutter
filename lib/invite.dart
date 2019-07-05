import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/launch_url.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitePage extends StatefulWidget {
  InvitePage({Key key}) : super(key: key);

  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  List _participants = [];
  List _contacts = [];
  bool loading = false;
  bool reloadContacts = false;
  String keywords;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getInitialData();
  }

  getInitialData() {
    loadContacts();
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
        excludeContacts(contacts);
      } catch (error) {
        setState(() {
          loading = false;
          reloadContacts = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

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
      backgroundColor: theme.addGroupParticipants.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.addGroupParticipants.appBackgroundColor,
        title: Container(
          alignment: Alignment.center,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            isThreeLine: false,
            title: Text(
              "Invite Friends",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
          ),
        ),
      ),
      body: loading != false
          ? showLoadingMessage()
          : showContacts(filteredContact),
    );
  }

  Column showContacts(List filteredContact) {
    return Column(
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
        Expanded(
          child: ListView.builder(
            primary: true,
            shrinkWrap: true,
            itemCount: filteredContact.length,
            itemBuilder: (context, index) {
              Map contact = filteredContact?.elementAt(index);

              return Container(
                color: exists(contact) ? Colors.green.shade50 : Colors.white,
                child: ListTile(
                  onTap: () => toggleContact(contact),
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: CachedNetworkImageProvider(
                      "$baseUrl/storage/${contact['avatar']}",
                    ),
                  ),
                  title: Text(
                    contact['givenName'] ?? contact['displayName'],
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
        ),
      ],
    );
  }

  Center showLoadingMessage() {
    return Center(
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
    );
  }

  excludeContacts(contacts) {
    List data = [];

    contacts.forEach((contact) {
      if (contact['id'] == null) {
        data.add(contact);
      }
    });

    setState(() {
      _contacts = data;
      loading = false;
      reloadContacts = false;
    });
  }

  exists(contact) {
    return _participants.contains(contact['id']);
  }

  toggleContact(contact) async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    String mobile = contact['mobile'];
    String text =
        "Join me on PauzR, an application that rewards you with free products, just for not using the phone. Download using this link and get 5 points as a kick-start. Join this human revolution! Link: $webUrl/invite/${userBloc.user.id}/$mobile";

    await launchURL(
      "whatsapp://send?phone=${contact['mobileWithCountryCode']}&text=$text",
    );
  }

  refreshContacts() async {
    var remoteContacts = [];

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

      remoteContacts = results;
    } catch (error) {
      print(error);
    }

    return remoteContacts;
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
