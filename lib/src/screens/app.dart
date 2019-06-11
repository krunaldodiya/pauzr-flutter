import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/generator.dart';
import 'package:pauzr/src/screens/initial_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  final String authToken;
  final String defaultTheme;

  MyApp({
    this.authToken,
    this.defaultTheme,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    await themeBloc.setTheme(DefaultTheme.defaultTheme(widget.defaultTheme));
    await userBloc.getAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.iOS),
      home: userBloc.loaded != true || themeBloc.loaded != true
          ? Center(child: CircularProgressIndicator())
          : InitialScreen(authToken: widget.authToken),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
