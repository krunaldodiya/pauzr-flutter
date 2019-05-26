import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;

class ViewProfilePage extends StatefulWidget {
  final bool shouldPop;

  ViewProfilePage({Key key, @required this.shouldPop}) : super(key: key);

  @override
  _ViewProfilePage createState() => _ViewProfilePage();
}

class _ViewProfilePage extends State<ViewProfilePage> {
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          userBloc.currentState.user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  routeList.edit_profile,
                  arguments: {
                    "shouldPop": true,
                  },
                );
              },
            ),
            margin: EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: userBloc,
        builder: (context, UserState state) {
          if (state.loaded == false) {
            return Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'profile-image',
                      child: Container(
                        child: ClipOval(
                          child: Image.network(
                            "$baseUrl/users/${state.user.avatar}",
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            "${state.user.name.toUpperCase()}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            state.user.gender == 'Male'
                                ? FontAwesome.male
                                : FontAwesome.female,
                          ),
                          title: Text(
                            "${state.user.gender}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.cake),
                          title: Text(
                            "${state.user.dob}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.edit_location),
                          title: Text(
                            "${state.user.location.city}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
