import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/location/bloc.dart';
import 'package:pauzr/src/blocs/location/state.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/location.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  LocationBloc _locationBloc;
  UserBloc _userBloc;
  String keywords;

  @override
  void initState() {
    super.initState();

    setState(() {
      _locationBloc = BlocProvider.of<LocationBloc>(context);
      _userBloc = BlocProvider.of<UserBloc>(context);
    });

    if (_locationBloc.currentState.loaded == false) {
      _locationBloc.getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: BlocBuilder(
          bloc: _locationBloc,
          builder: (context, LocationState state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            }

            List locations = state.locations;
            if (keywords != null) {
              locations = state.locations.where((location) {
                return location.city
                    .toLowerCase()
                    .contains(keywords.toLowerCase());
              }).toList();
            }

            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        keywords = value;
                      });
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'TitilliumWeb-Regular',
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      labelText: "Filter Location",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'TitilliumWeb-Regular',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (BuildContext context, index) {
                        final Location location = locations[index];
                        return GestureDetector(
                          onTap: () {
                            _userBloc.updateState("location", location);
                            Navigator.of(context).pop(location);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "${location.city}, ${location.state}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: Fonts.titilliumWebRegular,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
