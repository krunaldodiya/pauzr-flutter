import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/initial_screen/bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/helpers/notifications.dart';
import 'package:pauzr/src/routes/generator.dart';
import 'package:pauzr/src/screens/initial_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyApp extends StatefulWidget {
  final String authToken;

  MyApp({this.authToken});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  UserBloc userBloc;
  InitialScreenBloc initialScreenBloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    final settingAndroid = AndroidInitializationSettings('ic_launcher');
    final settingIos = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        return onSelectNotification(payload);
      },
    );

    notifications.initialize(
      InitializationSettings(settingAndroid, settingIos),
      onSelectNotification: onSelectNotification,
    );

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
      initialScreenBloc = BlocProvider.of<InitialScreenBloc>(context);

      userBloc.initialScreenBloc = initialScreenBloc;
    });

    userBloc.getAuthUser();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        showOngoingNotification(notifications, title: "", body: "", id: 1);
        break;

      case AppLifecycleState.inactive:
        print("inactive");
        break;

      case AppLifecycleState.resumed:
        print("resumed");
        break;

      case AppLifecycleState.suspending:
        print("suspending");
        break;

      default:
        print("default");
    }
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

  Future onSelectNotification(String payload) async {
    print(payload);
  }
}
