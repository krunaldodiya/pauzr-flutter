// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/generator.dart';
import 'package:pauzr/src/screens/initial_screen.dart';
import 'package:pauzr/src/screens/notifications.dart';
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
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  // final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    managePushNotifications();

    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    await themeBloc.setTheme(DefaultTheme.defaultTheme(widget.defaultTheme));
    await userBloc.getAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.android),
      home: InitialScreen(authToken: widget.authToken),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
      // ],
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  void managePushNotifications() async {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationsScreen(message: message),
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationsScreen(message: message),
          ),
        );
      },
    );

    firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }
}
