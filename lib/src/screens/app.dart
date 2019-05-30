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

    getInitialData();
  }

  void getInitialData() {
    Future.delayed(Duration(seconds: 1), () {
      final UserBloc userBloc = Provider.of<UserBloc>(context);
      final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

      themeBloc.setTheme(DefaultTheme.defaultTheme(widget.defaultTheme));
      userBloc.getAuthUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.iOS),
      home: themeBloc.theme == null
          ? Center(child: CircularProgressIndicator())
          : InitialScreen(
              authUser: userBloc.user,
              authToken: widget.authToken,
            ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
