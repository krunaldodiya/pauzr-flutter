import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/providers/country.dart';
import 'package:pauzr/src/providers/otp.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:provider/provider.dart';

class ChooseCountry extends StatefulWidget {
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  String keywords;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  void getInitialData() async {
    final CountryBloc countryBloc = Provider.of<CountryBloc>(context);

    if (countryBloc.countries.length == 0) {
      countryBloc.getCountries();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final OtpBloc otpBloc = Provider.of<OtpBloc>(context);
    final CountryBloc countryBloc = Provider.of<CountryBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    List locations = countryBloc.countries;

    if (countryBloc.loading == true) {
      return Center(child: CircularProgressIndicator());
    }

    if (keywords != null) {
      locations = countryBloc.countries.where((country) {
        return country.name.toLowerCase().contains(keywords.toLowerCase());
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
                  labelText: "Filter Countries",
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
                    final Country country = locations[index];

                    return GestureDetector(
                      onTap: () {
                        otpBloc.onChangeCountry(country);

                        Navigator.of(context).pop(country);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          country.name,
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
