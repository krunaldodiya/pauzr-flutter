import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/providers/location.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  String keywords;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  void getInitialData() async {
    final LocationBloc locationBloc = Provider.of<LocationBloc>(context);

    if (locationBloc.locations.length == 0) {
      locationBloc.getLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final LocationBloc locationBloc = Provider.of<LocationBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    List locations = locationBloc.locations;

    if (locationBloc.loading == true) {
      return Center(child: CircularProgressIndicator());
    }

    if (keywords != null) {
      locations = locationBloc.locations.where((location) {
        return location.city.toLowerCase().contains(keywords.toLowerCase());
      }).toList();
    }

    return Scaffold(
      backgroundColor: theme.editProfile.backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: theme.editProfile.cursorColor,
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
                        userBloc.onChangeData(
                          "location",
                          location,
                          userBloc.user,
                        );

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
        ),
      ),
    );
  }
}
