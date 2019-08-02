import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class ShowPhoto extends StatefulWidget {
  final photo;

  ShowPhoto({Key key, @required this.photo}) : super(key: key);

  @override
  _ShowPhoto createState() => _ShowPhoto();
}

class _ShowPhoto extends State<ShowPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Photo",
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
            imageUrl: widget.photo,
            placeholder: (context, url) {
              return Image.asset(
                "assets/images/loading.gif",
                width: double.infinity,
                height: null,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              );
            },
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
            width: double.infinity,
            height: null,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
