import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/city.dart';
import 'package:pauzr/src/providers/city.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';

class ChooseCity extends StatefulWidget {
  @override
  _ChooseCityState createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  String keywords;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  void getInitialData() async {
    final CityBloc cityBloc = Provider.of<CityBloc>(context);

    if (cityBloc.cities.length == 0) {
      cityBloc.getCities();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final CityBloc cityBloc = Provider.of<CityBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    List locations = cityBloc.cities;

    if (cityBloc.loading == true) {
      return Center(child: CircularProgressIndicator());
    }

    if (keywords != null) {
      locations = cityBloc.cities.where((city) {
        return city.name.toLowerCase().contains(keywords.toLowerCase());
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
                  labelText: "Filter Cities",
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
                    final City city = locations[index];

                    return GestureDetector(
                      onTap: () {
                        userBloc.onChangeData(
                          "location",
                          city,
                          userBloc.user,
                        );

                        Navigator.of(context).pop(city);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "${city.name}, ${city.state.name}",
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
