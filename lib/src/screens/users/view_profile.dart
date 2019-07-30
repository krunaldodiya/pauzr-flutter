import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final GalleryBloc galleryBloc = Provider.of<GalleryBloc>(context);

    galleryBloc.getUserGallery(reload: false, userId: widget.user.id);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrl/storage/${widget.user.avatar}",
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
              padding: EdgeInsets.all(10.0),
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
                      onPressed: () {},
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(1.0),
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.95),
                child: galleryBloc.images.length == 0
                    ? Container(
                        child: Text(
                          "No posts yet.",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: galleryBloc.images.length,
                        itemBuilder: (BuildContext context, int index) {
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
                              margin: EdgeInsets.all(1.0),
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
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
