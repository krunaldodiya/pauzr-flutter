import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/profession/bloc.dart';
import 'package:pauzr/src/blocs/profession/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/profession.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';

class ChooseProfession extends StatefulWidget {
  @override
  _ChooseProfessionState createState() => _ChooseProfessionState();
}

class _ChooseProfessionState extends State<ChooseProfession> {
  ProfessionBloc _professionBloc;
  String keywords;

  @override
  void initState() {
    super.initState();

    setState(() {
      _professionBloc = BlocProvider.of<ProfessionBloc>(context);
    });

    if (_professionBloc.currentState.loaded == false) {
      _professionBloc.getProfession();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: BlocBuilder(
          bloc: _professionBloc,
          builder: (context, ProfessionState state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            }

            List professions = state.professions;
            if (keywords != null) {
              professions = state.professions.where((profession) {
                return profession.name
                    .toLowerCase()
                    .contains(keywords.toLowerCase());
              }).toList();
            }

            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        keywords = value;
                      });
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'TitilliumWeb-Regular',
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      labelText: "Filter profession",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'TitilliumWeb-Regular',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: ListView.builder(
                      itemCount: professions.length,
                      itemBuilder: (BuildContext context, index) {
                        final Profession profession = professions[index];
                        return GestureDetector(
                          onTap: () {
                            userBloc.onChangeData(
                              "profession",
                              profession.name,
                            );
                            Navigator.of(context).pop(profession);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "${profession.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: Fonts.titilliumWebRegular,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
