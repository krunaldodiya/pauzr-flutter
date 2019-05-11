import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/screens/levels/levels.dart';
import 'package:pauzr/src/screens/levels/main_card.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key key}) : super(key: key);

  @override
  _LevelPage createState() => _LevelPage();
}

class _LevelPage extends State<LevelPage> with SingleTickerProviderStateMixin {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: userBloc,
        builder: (context, UserState state) {
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Text(
                "Levels".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 4.3,
                  ),
                  itemCount: levels.length,
                  itemBuilder: (context, int index) {
                    final level = levels[index];

                    return getMainCard(level, state.user);
                  },
                ),
              ),
            ),
          );
        });
  }
}
