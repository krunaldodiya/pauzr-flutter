import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/models/profession.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:pauzr/src/screens/users/tappable.dart';
import 'package:intl/intl.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class EditProfilePage extends StatefulWidget {
  final bool shouldPop;

  EditProfilePage({Key key, @required this.shouldPop}) : super(key: key);

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  UserBloc userBloc;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });

    nameController.text = userBloc.currentState.user.name;
    emailController.text = userBloc.currentState.user.email;
    dobController.text = userBloc.currentState.user.dob;
    genderController.text = userBloc.currentState.user.gender;
    locationController.text = userBloc.currentState.user.location.city;
    professionController.text = userBloc.currentState.user.profession.name;
  }

  Widget getLeadingIcon() {
    if (widget.shouldPop == true) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }

    return Icon(Icons.person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Edit Profile"),
        leading: getLeadingIcon(),
        actions: <Widget>[
          FlatButton(
            onPressed: onSubmit,
            child: Text(
              "SUBMIT",
              style: TextStyle(
                color: Colors.white,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(height: 20.0),
              BlocBuilder(
                bloc: userBloc,
                builder: (context, state) {
                  return EditableFormField(
                    controller: nameController,
                    labelText: "Full Name",
                    errorText: getErrorText(state, 'name'),
                    onChanged: (name) {
                      userBloc.updateState("name", name);
                    },
                  );
                },
              ),
              BlocBuilder(
                bloc: userBloc,
                builder: (context, state) {
                  return EditableFormField(
                    controller: emailController,
                    labelText: "Email Address",
                    errorText: getErrorText(state, 'email'),
                    onChanged: (email) {
                      userBloc.updateState("email", email);
                    },
                  );
                },
              ),
              GestureDetector(
                onTap: () async {
                  final String userDob = userBloc.currentState.user.dob;
                  List dateList = userDob.split("-");
                  DateTime intialDob = DateTime(
                    int.parse(dateList[2]),
                    int.parse(dateList[1]),
                    int.parse(dateList[0]),
                  );

                  final DateTime dob = await showDatePicker(
                    initialDatePickerMode: DatePickerMode.day,
                    context: context,
                    initialDate: intialDob,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (dob != null) {
                    String formattedDob = DateFormat('dd-MM-yyyy').format(dob);
                    setState(() => dobController.text = formattedDob);
                    userBloc.updateState("dob", formattedDob);
                  }
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: dobController,
                      labelText: "Date of Birth",
                      errorText: getErrorText(state, "dob"),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, routeList.gender).then((gender) {
                    final Location data = gender;

                    if (data != null) {
                      setState(() {
                        genderController.text = gender;
                      });
                    }
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: genderController,
                      labelText: "Gender",
                      errorText: getErrorText(state, "gender"),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, routeList.location)
                      .then((location) {
                    final Location data = location;

                    if (data != null) {
                      print(data.city);
                    }
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: locationController,
                      labelText: "Location",
                      errorText: getErrorText(state, "location_id"),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, routeList.profession)
                      .then((profession) {
                    final Profession data = profession;

                    if (data != null) {
                      print(data.name);
                    }
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: professionController,
                      labelText: "Profession",
                      errorText: getErrorText(state, "profession_id"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    XsProgressHud.show(context);

    userBloc.updateProfile((success) {
      XsProgressHud.hide();

      if (success == true) {
        if (widget.shouldPop == true) {
          return Navigator.of(context).pop();
        }

        return Navigator.pushReplacementNamed(context, routeList.tab);
      }
    });
  }
}
