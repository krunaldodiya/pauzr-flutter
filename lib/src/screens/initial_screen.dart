import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/initial_screen.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/no_network.dart';

class InitialScreen extends StatefulWidget {
  final String authToken;
  final UserBloc userBloc;
  final ThemeBloc themeBloc;

  InitialScreen({
    Key key,
    @required this.authToken,
    @required this.userBloc,
    @required this.themeBloc,
  }) : super(key: key);

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
    if (connectivityResult == ConnectivityResult.none) {
      return NoNetwork();
    }

    if (widget.userBloc.loading == true || widget.themeBloc.theme == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (widget.authToken == null) {
      return IntroPage();
    }

    return getInitialScreen(widget.userBloc.user);
  }
}
