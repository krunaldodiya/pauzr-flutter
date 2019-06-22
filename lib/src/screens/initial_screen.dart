import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/no_network.dart';
import 'package:pauzr/src/screens/otp/request_otp.dart';
import 'package:pauzr/src/screens/tabs.dart';
import 'package:pauzr/src/screens/users/edit_profile.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  final String authToken;

  InitialScreen({
    Key key,
    @required this.authToken,
  }) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  ConnectivityResult connectivityResult;
  var subscription;

  @override
  void initState() {
    super.initState();

    checkConnection();
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    if (connectivityResult == ConnectivityResult.none) {
      return NoNetwork();
    }

    if (widget.authToken == null || userBloc.user == null) {
      return RequestOtpPage();
    }

    if (userBloc.user.status == 1) {
      return TabsPage();
    }

    return EditProfilePage(shouldPop: false);
  }

  void checkConnection() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() => connectivityResult = result);
      },
    );
  }
}
