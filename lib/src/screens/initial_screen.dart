import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/initial_screen/bloc.dart';
import 'package:pauzr/src/blocs/initial_screen/state.dart';
import 'package:pauzr/src/helpers/initial_screen.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/no_network.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  final String authToken;
  final String defaultTheme;

  InitialScreen({
    Key key,
    @required this.authToken,
    @required this.defaultTheme,
  }) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  InitialScreenBloc initialScreenBloc;
  ConnectivityResult connectivityResult;
  var subscription;

  @override
  void initState() {
    super.initState();

    checkConnection();

    setState(() {
      initialScreenBloc = BlocProvider.of<InitialScreenBloc>(context);
    });
  }

  onLoad() {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    themeBloc.setTheme(DefaultTheme.defaultTheme(widget.defaultTheme));
  }

  void checkConnection() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() => connectivityResult = result);
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (connectivityResult == ConnectivityResult.none) {
      return NoNetwork();
    }

    if (widget.authToken == null) {
      return IntroPage();
    }

    return BlocBuilder(
      bloc: initialScreenBloc,
      builder: (context, InitialScreenState state) {
        if (state.loaded == false) {
          return Center(child: CircularProgressIndicator());
        }

        return getInitialScreen(state.user);
      },
    );
  }
}
