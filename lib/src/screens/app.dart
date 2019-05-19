import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/initial_screen/bloc.dart';
import 'package:pauzr/src/blocs/theme/bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/routes/generator.dart';
import 'package:pauzr/src/screens/initial_screen.dart';

class MyApp extends StatefulWidget {
  final String authToken;
  final String defaultTheme;

  MyApp({this.authToken, this.defaultTheme});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc themeBloc;
  UserBloc userBloc;
  InitialScreenBloc initialScreenBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      themeBloc = BlocProvider.of<ThemeBloc>(context);
      userBloc = BlocProvider.of<UserBloc>(context);
      initialScreenBloc = BlocProvider.of<InitialScreenBloc>(context);
    });

    themeBloc.setTheme(widget.defaultTheme);
    userBloc.getAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.iOS),
      home: InitialScreen(authToken: widget.authToken),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
