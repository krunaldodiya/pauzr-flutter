import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/no_network.dart';
import 'package:pauzr/src/screens/splash_screen.dart';
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
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    if (connectivityResult == ConnectivityResult.none) {
      return NoNetwork();
    }

    if (userBloc.loaded != true || themeBloc.loaded != true) {
      return SplashScreen();
    }

    if (widget.authToken == null && userBloc.user == null) {
      return IntroPage();
    }

    if (widget.authToken != null && userBloc.user == null) {
      return reloadAuthUser(userBloc);
    }

    return getAuthScreen(userBloc);
  }

  void checkConnection() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() => connectivityResult = result);
      },
    );
  }

  reloadAuthUser(UserBloc userBloc) {
    userBloc.getAuthUser();

    if (userBloc.user == null) {
      return SplashScreen();
    } else {
      return getAuthScreen(userBloc);
    }
  }

  Widget getAuthScreen(UserBloc userBloc) {
    if (userBloc.user.status == 1) {
      return TabsPage();
    }

    return EditProfilePage(shouldPop: false);
  }
}
