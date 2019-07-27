import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/providers/otp.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:pauzr/src/screens/users/tappable.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class RequestOtpPage extends StatefulWidget {
  RequestOtpPage({Key key}) : super(key: key);

  @override
  _RequestOtpPage createState() => _RequestOtpPage();
}

class _RequestOtpPage extends State<RequestOtpPage> {
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final OtpBloc otpBloc = Provider.of<OtpBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.requestOtp.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "REQUEST OTP",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    "Please enter your mobile to receive verifcation code.",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, routeList.country_list)
                        .then((location) {
                      final Country country = location;

                      if (country != null) {
                        setState(() {
                          countryController.text = country.name;
                        });
                      }
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  child: TappableFormField(
                    controller: countryController,
                    labelText: "Country",
                    errorText: getErrorText(otpBloc.error, "country_id"),
                  ),
                ),
                EditableFormField(
                  keyboardType: TextInputType.number,
                  labelText: "Mobile Number ( Without Country Code )",
                  errorText: getErrorText(otpBloc.error, 'mobile'),
                  onChanged: otpBloc.onChangeMobile,
                ),
                FlatButton(
                  onPressed: () {
                    if (otpBloc.isValidMobile == true) onRequestOtp(otpBloc);
                  },
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "SEND OTP",
                    style: TextStyle(
                      color:
                          otpBloc.isValidMobile ? Colors.white : Colors.white30,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                  color: otpBloc.isValidMobile ? Colors.red : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onRequestOtp(OtpBloc otpBloc) async {
    XsProgressHud.show(context);

    await otpBloc.requestOtp();

    XsProgressHud.hide();

    if (otpBloc.serverOtp != null) {
      return Navigator.pushReplacementNamed(context, routeList.verify_otp);
    }
  }
}
