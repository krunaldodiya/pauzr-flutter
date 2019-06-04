import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/group.dart';
import 'package:pauzr/src/providers/group.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ManageGroupPage extends StatefulWidget {
  final Group group;
  ManageGroupPage({Key key, this.group}) : super(key: key);

  _ManageGroupPageState createState() => _ManageGroupPageState();
}

class _ManageGroupPageState extends State<ManageGroupPage> {
  ApiProvider apiProvider = ApiProvider();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photoController =
      TextEditingController(text: "default.jpeg");

  bool loading;

  @override
  void initState() {
    super.initState();

    if (widget.group != null) {
      setState(() {
        nameController.text = widget.group.name;
        descriptionController.text = widget.group.description;
        photoController.text = widget.group.photo;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);

    if (groupBloc.loading == true) {
      XsProgressHud.show(context);
    }

    if (groupBloc.loading == false) {
      XsProgressHud.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final GroupBloc groupBloc = Provider.of<GroupBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.manageGroup.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.manageGroup.appBackgroundColor,
        title: Text(
          widget.group != null ? "Update Group" : "Create Group",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        actions: <Widget>[
          if (loading != true)
            FlatButton(
              onPressed: () {
                manageGroup(groupBloc);
              },
              child: Text(
                widget.group != null ? "Submit" : "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.dstATop,
                      ),
                      image: NetworkImage(
                        "$baseUrl/users/${photoController.text}",
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Center(
                  child: loading == true
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: uploadGroupImage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              Container(width: 5.0),
                              Text(
                                "Select a photo",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: Fonts.titilliumWebRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          Container(height: 10.0),
          EditableFormField(
            keyboardType: TextInputType.text,
            maxLength: 20,
            textColor: Colors.black,
            borderColor: Colors.black,
            labelColor: Colors.black,
            controller: nameController,
            labelText: "Group Name",
            errorText: getErrorText(groupBloc.error, 'name'),
          ),
          EditableFormField(
            maxLength: 100,
            maxLines: 3,
            textColor: Colors.black,
            borderColor: Colors.black,
            labelColor: Colors.black,
            controller: descriptionController,
            labelText: "Group Description",
            errorText: getErrorText(groupBloc.error, 'description'),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void uploadGroupImage() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      loading = true;
    });

    FormData formdata = FormData.from({
      "image": UploadFileInfo(file, file.path),
    });

    try {
      final response = await apiProvider.uploadGroupImage(formdata);
      final results = response.data;

      setState(() {
        photoController.text = results['name'];
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  void manageGroup(groupBloc) async {
    String name = nameController.text;
    String description = descriptionController.text;
    String photo = photoController.text;

    int groupId = widget.group != null ? widget.group.id : null;

    if (groupId != null) {
      await groupBloc.editGroup(groupId, name, description, photo);

      Navigator.pop(context);
    }

    if (groupId == null) {
      final Group group = await groupBloc.createGroup(name, description, photo);

      Navigator.pushReplacementNamed(
        context,
        routeList.add_group_participants,
        arguments: {"group": group},
      );
    }
  }
}
