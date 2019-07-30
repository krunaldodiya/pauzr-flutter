import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/gallery.dart';

class ShowPost extends StatefulWidget {
  final Gallery gallery;

  ShowPost({Key key, @required this.gallery}) : super(key: key);

  @override
  _ShowPost createState() => _ShowPost();
}

class _ShowPost extends State<ShowPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: CachedNetworkImage(
            imageUrl: widget.gallery.url,
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
      ),
    );
  }
}
