import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/initial_screen/bloc.dart';
import 'package:pauzr/src/blocs/otp/bloc.dart';
import 'package:pauzr/src/blocs/otp/event.dart';
import 'package:pauzr/src/blocs/otp/state.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class VerifyOtpPage extends StatefulWidget {
  VerifyOtpPage({Key key}) : super(key: key);

  @override
  _VerifyOtpPage createState() => _VerifyOtpPage();
}

class _VerifyOtpPage extends State<VerifyOtpPage> {
  DefaultTheme theme;
  OtpBloc otpBloc;
  UserBloc userBloc;
  InitialScreenBloc initialScreenBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      theme = ThemeProvider.defaultTheme();
      otpBloc = BlocProvider.of<OtpBloc>(context);
      userBloc = BlocProvider.of<UserBloc>(context);
      initialScreenBloc = BlocProvider.of<InitialScreenBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                BlocBuilder(
                  bloc: otpBloc,
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Please enter verification code send to ${state.mobile}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder(
                  bloc: otpBloc,
                  builder: (context, OtpState state) {
                    return FlatButton(
                      onPressed: onResendOtp,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontFamily: Fonts.titilliumWebSemiBold,
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<OtpEvent, OtpState>(
                  bloc: otpBloc,
                  builder: (BuildContext context, OtpState state) {
                    return EditableFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: null,
                      labelText: "OTP",
                      errorText: getErrorText(state, 'otp'),
                      onChanged: otpBloc.onChangeOtp,
                    );
                  },
                ),
                BlocBuilder<OtpEvent, OtpState>(
                  bloc: otpBloc,
                  builder: (BuildContext context, OtpState state) {
                    return FlatButton(
                      onPressed: onVerifyOtp,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "VERIFY OTP",
                        style: TextStyle(
                          color: state.clientOtp != null && state.error != null
                              ? Colors.white
                              : Colors.white30,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                      color: state.clientOtp != null && state.error != null
                          ? Colors.red
                          : Colors.grey,
                    );
                  },
                ),
                Container(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onResendOtp() {
    XsProgressHud.show(context);

    otpBloc.requestOtp(() {
      XsProgressHud.hide();
    });
  }

  void onVerifyOtp() {
    XsProgressHud.show(context);

    otpBloc.verifyOtp((results) {
      XsProgressHud.hide();

      if (results != false) {
        User user = User.fromMap(results['user']);

        userBloc.setAuthToken(results['access_token']);
        userBloc.setAuthUser(results['user']);

        if (user.status == 1) {
          return Navigator.of(context).pushReplacementNamed(
            routeList.tab,
            arguments: null,
          );
        }

        if (user.status == 0) {
          return Navigator.of(context).pushReplacementNamed(
            routeList.edit_profile,
            arguments: {"shouldPop": false},
          );
        }
      }
    });
  }
}
