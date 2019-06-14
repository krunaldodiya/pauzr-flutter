import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:pauzr/src/screens/users/tappable.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class EditProfilePage extends StatefulWidget {
  final bool shouldPop;

  EditProfilePage({Key key, @required this.shouldPop}) : super(key: key);

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  ApiProvider _apiProvider = ApiProvider();
  bool loading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    nameController.text = userBloc.user.name;
    emailController.text = userBloc.user.email;
    dobController.text = userBloc.user.dob;
    genderController.text = userBloc.user.gender;
    locationController.text = userBloc.user.location.city;
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
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.editProfile.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.editProfile.backgroundColor,
        title: Text(
          "Edit Profile".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Colors.white,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
        leading: getLeadingIcon(),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              onSubmit(userBloc);
            },
            child: Text(
              "SUBMIT",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
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
              if (widget.shouldPop == true) photoUpload(userBloc),
              EditableFormField(
                cursorColor: theme.editProfile.cursorColor,
                controller: nameController,
                labelText: "Full Name",
                errorText: getErrorText(userBloc.error, 'name'),
                onChanged: (name) {
                  userBloc.onChangeData("name", name, userBloc.user);
                },
              ),
              EditableFormField(
                cursorColor: theme.editProfile.cursorColor,
                controller: emailController,
                labelText: "Email Address",
                errorText: getErrorText(userBloc.error, 'email'),
                onChanged: (email) {
                  userBloc.onChangeData("email", email, userBloc.user);
                },
              ),
              GestureDetector(
                onTap: () async {
                  final String userDob = userBloc.user.dob;
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
                    userBloc.onChangeData("dob", formattedDob, userBloc.user);
                  }
                },
                child: TappableFormField(
                  controller: dobController,
                  labelText: "Date of Birth",
                  errorText: getErrorText(userBloc.error, "dob"),
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
                child: TappableFormField(
                  controller: genderController,
                  labelText: "Gender",
                  errorText: getErrorText(userBloc.error, "gender"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, routeList.location)
                      .then((location) {
                    final Location data = location;

                    if (data != null) {
                      setState(() {
                        locationController.text = data.city;
                      });
                    }
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: TappableFormField(
                  controller: locationController,
                  labelText: "Location",
                  errorText: getErrorText(userBloc.error, "location_id"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  photoUpload(userBloc) {
    return GestureDetector(
      onTap: () {
        uploadImage(userBloc);
      },
      child: Container(
        height: 120.0,
        width: 120.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: ClipOval(
          child: loading == false
              ? Image.network(
                  "$baseUrl/users/${userBloc.user.avatar}",
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  onSubmit(UserBloc userBloc) async {
    XsProgressHud.show(context);

    await userBloc.updateProfile(userBloc.user);

    XsProgressHud.hide();

    if (userBloc.loaded == true) {
      if (widget.shouldPop == true) {
        Navigator.of(context).pop();
      } else {
        Navigator.pushReplacementNamed(context, routeList.tab);
      }
    }
  }

  void uploadImage(userBloc) async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    XsProgressHud.show(context);

    setState(() {
      loading = true;
    });

    FormData formdata = FormData.from({
      "image": UploadFileInfo(file, file.path),
    });

    try {
      final response = await _apiProvider.uploadAvatar(formdata);
      final results = response.data;

      await userBloc.setAuthUser(results['user']);

      XsProgressHud.hide();

      setState(() {
        loading = false;
      });
    } catch (e) {
      XsProgressHud.hide();

      setState(() {
        loading = false;
      });
    }
  }
}
