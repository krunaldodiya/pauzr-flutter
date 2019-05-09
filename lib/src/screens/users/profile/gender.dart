import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class ChooseGender extends StatefulWidget {
  @override
  _ChooseGenderState createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      _userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Hello, There",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontFamily: Fonts.titilliumWebSemiBold,
                  ),
                ),
              ),
              Container(height: 10.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Select your Gender",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
              ),
              Container(height: 50.0),
              BlocBuilder(
                bloc: _userBloc,
                builder: (context, UserState state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _userBloc.updateState("gender", "Male"),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20.0),
                          child: Opacity(
                            opacity: state.user.gender == "Male" ? 1 : 0.4,
                            child: Image.asset(
                              "assets/images/man.png",
                              width: 120.0,
                              height: 120.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _userBloc.updateState("gender", "Female"),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20.0),
                          child: Opacity(
                            opacity: state.user.gender == "Female" ? 1 : 0.4,
                            child: Image.asset(
                              "assets/images/woman.png",
                              width: 120.0,
                              height: 120.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Container(height: 50.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 70.0),
                child: FlatButton(
                  child: Text(
                    "OKAY",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25.0,
                      fontFamily: Fonts.titilliumWebBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(
                      _userBloc.currentState.user.gender,
                    );
                  },
                ),
              ),
              Container(height: 10.0),
              Container(
                child: FlatButton(
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontFamily: Fonts.titilliumWebRegular,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(
                      _userBloc.currentState.user.gender,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
