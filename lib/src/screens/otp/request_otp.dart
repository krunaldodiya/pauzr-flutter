import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/otp/bloc.dart';
import 'package:pauzr/src/blocs/otp/event.dart';
import 'package:pauzr/src/blocs/otp/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class RequestOtpPage extends StatefulWidget {
  RequestOtpPage({Key key}) : super(key: key);

  @override
  _RequestOtpPage createState() => _RequestOtpPage();
}

class _RequestOtpPage extends State<RequestOtpPage> {
  OtpBloc otpBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      otpBloc = BlocProvider.of<OtpBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
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
                BlocBuilder<OtpEvent, OtpState>(
                  bloc: otpBloc,
                  builder: (BuildContext context, OtpState state) {
                    return EditableFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: null,
                      labelText: "Mobile Number",
                      errorText: getErrorText(state, 'mobile'),
                      onChanged: otpBloc.onChangeMobile,
                    );
                  },
                ),
                BlocBuilder<OtpEvent, OtpState>(
                  bloc: otpBloc,
                  builder: (BuildContext context, OtpState state) {
                    return FlatButton(
                      onPressed: onSubmit,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "SEND OTP",
                        style: TextStyle(
                          color: state.mobile != null && state.error != null
                              ? Colors.white
                              : Colors.white30,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                      color: state.mobile != null && state.error != null
                          ? Colors.red
                          : Colors.grey,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    XsProgressHud.show(context);

    otpBloc.requestOtp((success) {
      XsProgressHud.hide();

      if (success == true) {
        return Navigator.pushReplacementNamed(context, routeList.verify_otp);
      }
    });
  }
}
