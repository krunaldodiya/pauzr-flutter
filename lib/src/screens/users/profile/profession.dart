import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/profession.dart';
import 'package:pauzr/src/providers/profession.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:provider/provider.dart';

class ChooseProfession extends StatefulWidget {
  @override
  _ChooseProfessionState createState() => _ChooseProfessionState();
}

class _ChooseProfessionState extends State<ChooseProfession> {
  String keywords;

  @override
  void initState() {
    super.initState();

    getInitialData();
  }

  void getInitialData() {
    Future.delayed(Duration(seconds: 1), () {
      final ProfessionBloc professionBloc =
          Provider.of<ProfessionBloc>(context);

      if (professionBloc.loaded == false) {
        professionBloc.getProfessions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ProfessionBloc professionBloc = Provider.of<ProfessionBloc>(context);

    List professions = professionBloc.professions;

    if (keywords != null) {
      professions = professionBloc.professions.where((profession) {
        return profession.name.toLowerCase().contains(keywords.toLowerCase());
      }).toList();
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
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
                          userBloc.user,
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
        ),
      ),
    );
  }
}
