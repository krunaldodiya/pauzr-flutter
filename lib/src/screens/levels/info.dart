import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/screens/levels/info_card.dart';
import 'package:pauzr/src/screens/levels/levels.dart';
import 'package:pauzr/src/screens/levels/main_card.dart';

class LevelsPage extends StatefulWidget {
  LevelsPage({Key key}) : super(key: key);

  @override
  _LevelsPage createState() => _LevelsPage();
}

class _LevelsPage extends State<LevelsPage>
    with SingleTickerProviderStateMixin {
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

              return BlocBuilder(
                bloc: userBloc,
                builder: (context, UserState state) {
                  return FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      child: getMainCard(level, state.user),
                    ),
                    back: Container(
                      child: getInfoCard(level, state.user),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
