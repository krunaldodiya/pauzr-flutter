import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class GroupDetailPage extends StatefulWidget {
  final group;

  GroupDetailPage({
    Key key,
    @required this.group,
  }) : super(key: key);

  @override
  _GroupDetailPage createState() => _GroupDetailPage();
}

class _GroupDetailPage extends State<GroupDetailPage> {
  GroupBloc groupBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      groupBloc = BlocProvider.of<GroupBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.groupDetail.backgroundColor,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: theme.groupDetail.appBackgroundColor,
                centerTitle: true,
                expandedHeight: 240.0,
                title: Text(
                  widget.group['name'].toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstATop,
                        ),
                        image: NetworkImage(
                          "$baseUrl/users/${widget.group['photo']}",
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        routeList.manage_group,
                        arguments: {
                          "group": widget.group,
                        },
                      );
                    },
                    icon: Icon(Icons.edit),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  widget.group['description'] != null
                      ? showGroupDescription()
                      : addGroupDescription(userBloc),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 5, color: Colors.grey),
                      ),
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate(addLabel(userBloc)),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  getParticipants(widget.group['subscribers'], userBloc),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(addParticipants(userBloc)),
              ),
              SliverList(
                delegate: SliverChildListDelegate(inviteFriends()),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 5, color: Colors.grey),
                      ),
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  groupAction(userBloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showGroupDescription() {
    List<Widget> data = [];

    data.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 18.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              widget.group['description'],
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
        ],
      ),
    );

    return data;
  }

  groupAction(userBloc) {
    List<Widget> data = [];

    String msg =
        userBloc.user.id == widget.group['owner_id'] ? "delete" : "exit";

    data.add(
      InkWell(
        onTap: () {
          return showConfirmationPopup(
            context,
            "Are you sure want to $msg ?",
            () {
              manageGroup(widget.group['id'], userBloc);
            },
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0),
          leading: Icon(
            msg == "delete" ? Icons.delete : Icons.exit_to_app,
            color: Colors.red,
            size: 30.0,
          ),
          title: Text(
            msg.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
      ),
    );

    return data;
  }

  addParticipants(userBloc) {
    List<Widget> data = [];

    if (userBloc.user.id == widget.group['owner_id']) {
      data.add(
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeList.add_group_participants,
              arguments: {
                "group": widget.group,
              },
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(
              Icons.add_circle,
              color: Colors.blue,
              size: 30.0,
            ),
            title: Text(
              "Add Participants",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
        ),
      );
    }

    return data;
  }

  inviteFriends() {
    List<Widget> data = [];

    data.add(
      InkWell(
        onTap: () {
          Share.share('check out Pauzr App $appId').then((data) {
            print("data");
          });
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0),
          leading: Icon(
            Icons.share,
            color: Colors.blue,
            size: 30.0,
          ),
          title: Text(
            "Invite Friends",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 16.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
      ),
    );

    return data;
  }

  addGroupDescription(userBloc) {
    List<Widget> data = [];

    if (userBloc.user.id == widget.group['owner_id']) {
      data.add(
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeList.manage_group,
              arguments: {
                "group": widget.group,
              },
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Icon(
              Icons.edit,
              color: Colors.blue,
              size: 30.0,
            ),
            title: Text(
              "Add Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
        ),
      );
    }

    return data;
  }

  addLabel(userBloc) {
    List<Widget> data = [];

    data.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              "Participants (${widget.group['subscribers'].length})",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
          if (userBloc.user.id == widget.group['owner_id'])
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeList.add_group_participants,
                  arguments: {
                    "group": widget.group,
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Text(
                  "ADD",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    fontSize: 16.0,
                    fontFamily: Fonts.titilliumWebSemiBold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return data;
  }

  List<Widget> getParticipants(List participants, UserBloc userBloc) {
    List<Widget> data = [];

    participants.forEach(
      (participant) {
        data.add(
          ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                "$baseUrl/users/${participant['info']['avatar']}",
              ),
            ),
            title: Text(
              participant['info']['name'].toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            subtitle: Text(
              participant['info']['location']['city'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 12.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: participant['info']['id'] == widget.group['owner_id']
                ? IconButton(
                    icon: Icon(Icons.verified_user, color: Colors.grey),
                    onPressed: null,
                  )
                : userBloc.user.id == widget.group['owner_id']
                    ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          return showConfirmationPopup(
                            context,
                            "Are you sure want to remove ?",
                            () {
                              removeUser(
                                widget.group['id'],
                                participant['info']['id'],
                              );
                            },
                          );
                        },
                      )
                    : null,
          ),
        );
      },
    );

    data.add(
      Container(
        height: 1.0,
        color: Colors.grey.shade300,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      ),
    );

    return data;
  }

  removeUser(groupId, userId) {
    groupBloc.exitGroup(groupId, userId, (data) {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  manageGroup(groupId, userBloc) {
    var userId = userBloc.user.id;

    groupBloc.exitGroup(groupId, userId, (data) {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }
}
