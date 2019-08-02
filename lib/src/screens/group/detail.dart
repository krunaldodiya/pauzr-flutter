import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/group.dart';
import 'package:pauzr/src/models/group_subscription.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/group.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class GroupDetailPage extends StatefulWidget {
  final Group group;

  GroupDetailPage({
    Key key,
    @required this.group,
  }) : super(key: key);

  @override
  _GroupDetailPage createState() => _GroupDetailPage();
}

class _GroupDetailPage extends State<GroupDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);

    if (groupBloc.loading == true) {
      XsProgressHud.show(context);
    }

    if (groupBloc.loading == false) {
      XsProgressHud.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    final groupSelector =
        groupBloc.groups.where((group) => group.id == widget.group.id);

    final Group group = groupSelector.length > 0 ? groupSelector.first : null;

    if (group == null) {
      return Center(child: CircularProgressIndicator());
    }

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
                  group.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        routeList.show_photo,
                        arguments: {
                          "photo": "$baseUrl/storage/${group.photo}",
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.dstATop,
                          ),
                          image: CachedNetworkImageProvider(
                            "$baseUrl/storage/${group.photo}",
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  if (group.owner.id == userBloc.user.id)
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          routeList.manage_group,
                          arguments: {
                            "group": group,
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  group.description != null
                      ? showGroupDescription(group)
                      : addGroupDescription(userBloc, group),
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
                delegate: SliverChildListDelegate(
                  addLabel(userBloc, group),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  getParticipants(
                    group.subscriptions,
                    groupBloc,
                    userBloc,
                    group,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  addParticipants(userBloc, group),
                ),
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
                  groupAction(groupBloc, userBloc, group),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showGroupDescription(group) {
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
              group.description,
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

  groupAction(groupBloc, userBloc, group) {
    List<Widget> data = [];

    String action;
    String message;

    if (userBloc.user.id == group.owner.id) {
      action = "delete";
      message =
          "Group will be deleted for all users. This action cannot be undone later.";
    } else {
      action = "exit";
      message = "Are you sure want to $action '${group.name}' group ?";
    }

    data.add(
      InkWell(
        onTap: () {
          return showConfirmationPopup(
            context,
            yesText: toBeginningOfSentenceCase(action),
            noText: "Cancel",
            message: message,
            onPressYes: () {
              action == "delete"
                  ? deleteGroup(groupBloc, group, userBloc.user)
                  : exitGroup(groupBloc, group, userBloc.user);
            },
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0),
          leading: Icon(
            action == "delete" ? Icons.delete : Icons.exit_to_app,
            color: Colors.red,
            size: 30.0,
          ),
          title: Text(
            action.toUpperCase(),
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

  addParticipants(userBloc, group) {
    List<Widget> data = [];

    if (userBloc.user.id == group.owner.id) {
      data.add(
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeList.add_group_participants,
              arguments: {
                "group": group,
                "shouldPop": true,
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
          Share.share(shareText).then((data) {
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

  addGroupDescription(userBloc, group) {
    List<Widget> data = [];

    if (userBloc.user.id == group.owner.id) {
      data.add(
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeList.manage_group,
              arguments: {
                "group": group,
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

  addLabel(userBloc, group) {
    List<Widget> data = [];

    data.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              "Participants (${group.subscriptions.length})",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ),
          if (userBloc.user.id == group.owner.id)
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeList.add_group_participants,
                  arguments: {
                    "group": group,
                    "shouldPop": true,
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

  List<Widget> getParticipants(List<GroupSubscription> participants,
      GroupBloc groupBloc, UserBloc userBloc, Group group) {
    List<Widget> data = [];

    participants.forEach(
      (participant) {
        data.add(
          ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/storage/${participant.subscriber.avatar}",
                placeholder: (context, url) {
                  return Image.asset(
                    "assets/images/loading.gif",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            title: Text(
              participant.subscriber.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            subtitle: Text(
              participant.subscriber.city.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 12.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: participant.subscriber.id == group.owner.id
                ? IconButton(
                    icon: Icon(Icons.verified_user, color: Colors.grey),
                    onPressed: null,
                  )
                : userBloc.user.id != group.owner.id
                    ? null
                    : IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          return showConfirmationPopup(
                            context,
                            yesText: "Remove",
                            noText: "Cancel",
                            message:
                                "Remove this user from '${group.name}' group ?",
                            onPressYes: () {
                              removeParticipant(
                                groupBloc,
                                group,
                                participant.subscriber,
                              );
                            },
                          );
                        },
                      ),
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

  exitGroup(GroupBloc groupBloc, Group group, User user) async {
    await groupBloc.exitGroup(group.id, user.id);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  deleteGroup(GroupBloc groupBloc, Group group, User user) async {
    await groupBloc.deleteGroup(group.id, user.id);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  removeParticipant(GroupBloc groupBloc, Group group, User user) async {
    await groupBloc.removeParticipants(group.id, user.id);
  }
}
