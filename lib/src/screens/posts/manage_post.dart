import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/validation.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/post.dart';
import 'package:pauzr/src/providers/post.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:pauzr/src/screens/users/editable.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ManagePostPage extends StatefulWidget {
  final Post post;

  ManagePostPage({
    Key key,
    this.post,
  }) : super(key: key);

  _ManagePostPageState createState() => _ManagePostPageState();
}

class _ManagePostPageState extends State<ManagePostPage> {
  ApiProvider _apiProvider = ApiProvider();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController photoController =
      TextEditingController(text: "default.jpeg");

  @override
  void initState() {
    super.initState();

    print(widget.post);

    if (widget.post != null) {
      setState(() {
        descriptionController.text = widget.post.description;
        photoController.text = widget.post.url;
      });
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    photoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final PostBloc postBloc = Provider.of<PostBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.manageGroup.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.manageGroup.appBackgroundColor,
        title: Text(
          widget.post != null ? "Update Post" : "Create Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        actions: <Widget>[
          if (postBloc.loading != true)
            FlatButton(
              onPressed: () {
                widget.post == null ? createPost(postBloc) : editPost(postBloc);
              },
              child: Text(
                widget.post != null ? "Update" : "Create",
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
                      image: CachedNetworkImageProvider(
                        "$baseUrl/storage/${photoController.text}",
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Center(
                  child: postBloc.loading == true
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            uploadPostImage(userBloc, postBloc);
                          },
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
            cursorColor: theme.manageGroup.cursorColor,
            maxLength: 100,
            maxLines: 3,
            textColor: Colors.black,
            borderColor: Colors.black,
            labelColor: Colors.black,
            controller: descriptionController,
            labelText: "Description",
            errorText: getErrorText(postBloc.error, 'description'),
          ),
        ],
      ),
    );
  }

  void uploadPostImage(UserBloc userBloc, PostBloc postBloc) async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final File file = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );

    FormData formdata = FormData.from({
      "image": UploadFileInfo(file, file.path),
    });

    try {
      XsProgressHud.show(context);
      final response = await _apiProvider.uploadPostImage(formdata);
      XsProgressHud.hide();

      final results = response.data;

      setState(() {
        photoController.text = results['name'];
      });
    } catch (e) {
      XsProgressHud.hide();
    }
  }

  void createPost(PostBloc postBloc) async {
    String description = descriptionController.text;
    String photo = photoController.text;

    XsProgressHud.show(context);
    await postBloc.createPost(description, photo);
    XsProgressHud.hide();

    Navigator.pop(context);
  }

  void editPost(PostBloc postBloc) async {
    String description = descriptionController.text;
    String photo = photoController.text;

    XsProgressHud.show(context);

    final Post post = await postBloc.editPost(
      widget.post.id,
      description,
      photo,
    );

    XsProgressHud.hide();

    Navigator.of(context).pop(post);
  }
}
