import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/providers/otp.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class VerifyOtpPage extends StatefulWidget {
  VerifyOtpPage({Key key}) : super(key: key);

  @override
  _VerifyOtpPage createState() => _VerifyOtpPage();
}

class _VerifyOtpPage extends State<VerifyOtpPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final OtpBloc otpBloc = Provider.of<OtpBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.verifyOtp.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "VERIFY OTP",
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
                  child: Text(
                    "Please enter verification code send to ${otpBloc.mobile}",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: otpBloc.requestOtp,
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                      fontFamily: Fonts.titilliumWebSemiBold,
                    ),
                  ),
                ),
                EditableFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: null,
                  labelText: "OTP",
                  errorText: getErrorText(otpBloc.error, 'otp'),
                  onChanged: otpBloc.onChangeClientOtp,
                ),
                FlatButton(
                  onPressed: () {
                    if (otpBloc.isValidMobile == true)
                      verifyOtp(otpBloc, userBloc);
                  },
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "VERIFY OTP",
                    style: TextStyle(
                      color: otpBloc.isValidOtp ? Colors.white : Colors.white30,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                  color: otpBloc.isValidOtp ? Colors.red : Colors.grey,
                ),
                Container(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyOtp(OtpBloc otpBloc, UserBloc userBloc) async {
    XsProgressHud.show(context);

    await otpBloc.verifyOtp(userBloc);

    XsProgressHud.hide();

    if (userBloc.error == null) {
      if (userBloc.user.status == 1) {
        Navigator.of(context).pushReplacementNamed(routeList.tab);
      }

      if (userBloc.user.status == 0) {
        Navigator.of(context).pushReplacementNamed(
          routeList.edit_profile,
          arguments: {"shouldPop": false},
        );
      }
    }
  }
}
