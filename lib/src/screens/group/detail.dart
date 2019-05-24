import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';

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
                      title: Text(
                        "by: ${widget.group['owner']['name']}",
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
        Container(
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
      );
    }

    data.add(
      Container(
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
    );

    return data;
  }

  List<Widget> getParticipants(List participants) {
    List<Widget> data = [];

    data.add(
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
    );

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
        ),
      );
    });

    return data;
  }
}
