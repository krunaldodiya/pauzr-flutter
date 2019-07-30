import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/gallery.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/gallery.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ViewProfilePage extends StatefulWidget {
  final bool shouldPop;
  final User user;

  ViewProfilePage({
    Key key,
    @required this.shouldPop,
    @required this.user,
  }) : super(key: key);

  @override
  _ViewProfilePage createState() => _ViewProfilePage();
}

class _ViewProfilePage extends State<ViewProfilePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final GalleryBloc galleryBloc = Provider.of<GalleryBloc>(context);
    galleryBloc.getUserGallery(reload: false, userId: widget.user.id);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        galleryBloc.getUserGallery(reload: true, userId: widget.user.id);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final GalleryBloc galleryBloc = Provider.of<GalleryBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.viewProfile.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.viewProfile.backgroundColor,
        title: Text(
          widget.user.name.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        actions: <Widget>[
          if (widget.user.id == userBloc.user.id)
            Container(
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    routeList.edit_profile,
                    arguments: {
                      "shouldPop": true,
                    },
                  );
                },
              ),
              margin: EdgeInsets.only(right: 10.0),
            ),
        ],
      ),
      body: SafeArea(
        child: galleryBloc.loading == true
            ? Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.white,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "$baseUrl/storage/${widget.user.avatar}",
                                  placeholder: (context, url) {
                                    return CircularProgressIndicator();
                                  },
                                  errorWidget: (context, url, error) {
                                    return Icon(Icons.error);
                                  },
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      galleryBloc.images.length.toString(),
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(height: 10.0),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "302",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(height: 10.0),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "15K",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(height: 10.0),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: userBloc.user.id == widget.user.id
                              ? RaisedButton(
                                  child: Text(
                                    "Create Post",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    createPost(userBloc, galleryBloc);
                                  },
                                )
                              : RaisedButton(
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                        ),
                      ]),
                    ),
                    getGridView(galleryBloc),
                  ],
                ),
              ),
      ),
    );
  }

  getGridView(GalleryBloc galleryBloc) {
    if (galleryBloc.images.length == 0) {
      return SliverList(
        delegate: SliverChildListDelegate([
          Container(
            alignment: Alignment.center,
            height: 300.0,
            child: Text(
              "No posts yet.",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
          ),
        ]),
      );
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Gallery gallery = galleryBloc.images[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                routeList.show_post,
                arguments: {"gallery": gallery},
              );
            },
            child: Container(
              margin: EdgeInsets.all(2.0),
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/storage/${gallery.url}",
                placeholder: (context, url) {
                  return CircularProgressIndicator();
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          );
        },
        childCount: galleryBloc.images.length,
      ),
    );
  }

  void createPost(UserBloc userBloc, GalleryBloc galleryBloc) async {
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

    XsProgressHud.show(context);
    await galleryBloc.createPost(userBloc, galleryBloc, formdata);
    XsProgressHud.hide();
  }
}
