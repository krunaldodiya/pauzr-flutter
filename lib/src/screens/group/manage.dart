import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pauzr/src/blocs/group/bloc.dart';
import 'package:pauzr/src/blocs/group/state.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ManageGroupPage extends StatefulWidget {
  final group;
  ManageGroupPage({Key key, this.group}) : super(key: key);

  _ManageGroupPageState createState() => _ManageGroupPageState();
}

class _ManageGroupPageState extends State<ManageGroupPage> {
  ApiProvider apiProvider = ApiProvider();
  GroupBloc groupBloc;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photoController =
      TextEditingController(text: "default.jpeg");

  bool loading;

  @override
  void initState() {
    super.initState();

    setState(() {
      groupBloc = BlocProvider.of<GroupBloc>(context);
    });

    if (widget.group != null) {
      setState(() {
        nameController.text = widget.group['name'];
        descriptionController.text = widget.group['description'];
        photoController.text = widget.group['photo'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
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
              onPressed: createGroup,
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
          BlocBuilder(
            bloc: groupBloc,
            builder: (context, GroupState state) {
              return EditableFormField(
                keyboardType: TextInputType.text,
                maxLength: 20,
                textColor: Colors.black,
                borderColor: Colors.black,
                labelColor: Colors.black,
                controller: nameController,
                labelText: "Group Name",
                errorText: getErrorText(state.error, 'name'),
              );
            },
          ),
          BlocBuilder(
            bloc: groupBloc,
            builder: (context, GroupState state) {
              return EditableFormField(
                maxLength: 100,
                maxLines: 3,
                textColor: Colors.black,
                borderColor: Colors.black,
                labelColor: Colors.black,
                controller: descriptionController,
                labelText: "Group Description",
                errorText: getErrorText(state.error, 'description'),
              );
            },
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

  void createGroup() {
    XsProgressHud.show(context);

    String name = nameController.text;
    String description = descriptionController.text;
    String photo = photoController.text;
    int groupId = widget.group != null ? widget.group['id'] : null;

    var callback = (data) {
      XsProgressHud.hide();

      if (data.runtimeType != DioError) {
        if (widget.group != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          Navigator.pushReplacementNamed(
            context,
            routeList.add_group_participants,
            arguments: {"group": data['group']},
          );
        }
      }
    };

    if (groupId != null) {
      groupBloc.editGroup(groupId, name, description, photo, callback);
    } else {
      groupBloc.createGroup(name, description, photo, callback);
    }
  }
}
