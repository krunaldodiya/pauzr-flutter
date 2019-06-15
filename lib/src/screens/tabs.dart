import 'package:flutter/material.dart';
import 'package:pauzr/app_bar.dart';
import 'package:pauzr/bottom_navigation.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/tabs.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/drawer.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPage createState() => _TabsPage();
}

class _TabsPage extends State<TabsPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.tabs.backgroundColor,
      appBar: getAppBar(context, userBloc, theme),
      body: SafeArea(child: getTabsPage(userBloc.tabIndex)),
      bottomNavigationBar: getNavigationBar(userBloc, theme),
      drawer: Drawer(
        child: DrawerPage(userBloc: userBloc, themeBloc: themeBloc),
      ),
    );
  }
}
