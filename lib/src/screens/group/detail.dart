import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

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
  UserBloc userBloc;
  GroupBloc groupBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
      groupBloc = BlocProvider.of<GroupBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: BlocBuilder(
        bloc: userBloc,
        builder: (context, UserState state) {
          if (state.loaded == false) {
            return Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Container(
              color: Colors.white,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    backgroundColor: Colors.red,
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
                      centerTitle: true,
                      title: Text(
                        widget.group['description'],
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
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
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(exitGroup()),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      addLabel(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      getParticipants(widget.group['subscribers']),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  exitGroup() {
    List<Widget> data = [];

    if (userBloc.currentState.user.id == widget.group['owner_id']) {
      data.add(
        InkWell(
          onTap: () {
            manageGroup(widget.group['id']);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.red),
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Delete Group",
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
    } else {
      data.add(
        InkWell(
          onTap: () {
            manageGroup(widget.group['id']);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.red),
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Exit Group",
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
    }

    return data;
  }

  addLabel() {
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

  List<Widget> getParticipants(List participants) {
    List<Widget> data = [];

    participants.forEach((participant) {
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
              : userBloc.currentState.user.id == widget.group['owner_id']
                  ? IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        removeUser(
                            widget.group['id'], participant['info']['id']);
                      },
                    )
                  : null,
        ),
      );
    });

    return data;
  }

  removeUser(groupId, userId) {
    print("$groupId, $userId");
  }

  manageGroup(groupId) {
    groupBloc.exitGroup(groupId, (data) {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }
}
