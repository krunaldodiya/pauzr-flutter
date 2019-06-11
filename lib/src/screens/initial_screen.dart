import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/initial_screen.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/no_network.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  final String authToken;

  InitialScreen({Key key, @required this.authToken}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  ConnectivityResult connectivityResult;
  var subscription;

  void checkConnection() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() => connectivityResult = result);
      },
    );
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

    if (widget.authToken == null) {
      return IntroPage();
    }

    return getInitialScreen(userBloc.user);
  }
}
