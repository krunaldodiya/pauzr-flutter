import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/providers/category.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/resources/client.dart';
import 'package:provider/provider.dart';

class BazaarPage extends StatefulWidget {
  BazaarPage({Key key}) : super(key: key);

  @override
  _BazaarPage createState() => _BazaarPage();
}

class _BazaarPage extends State<BazaarPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final CategoryBloc categoryBloc = Provider.of<CategoryBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.mainScoreboard.backgroundColor,
      body: SafeArea(
        child: categoryBloc.loaded != true
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    categoryBloc.categories[0]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getInitialData() async {
    final CategoryBloc categoryBloc = Provider.of<CategoryBloc>(context);
    categoryBloc.getCategories();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }
}
