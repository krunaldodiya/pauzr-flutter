import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/favorite.dart';
import 'package:pauzr/src/models/post.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/post.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:pauzr/src/screens/helpers/error.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ShowPost extends StatefulWidget {
  final Post post;
  final User guestUser;

  ShowPost({
    Key key,
    @required this.post,
    @required this.guestUser,
  }) : super(key: key);

  @override
  _ShowPost createState() => _ShowPost();
}

class _ShowPost extends State<ShowPost> {
  Post post;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final PostBloc postBloc = Provider.of<PostBloc>(context);
    final Post postData = await postBloc.getPostDetail(widget.post.id);

    setState(() {
      post = postData;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final PostBloc postBloc = Provider.of<PostBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: theme.editProfile.backgroundColor,
        centerTitle: true,
        title: Text(
          "Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
      body: SafeArea(
        child: post == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: getBody(userBloc, postBloc, context),
              ),
      ),
    );
  }

  Column getBody(UserBloc userBloc, PostBloc postBloc, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/storage/${post.owner.avatar}",
                placeholder: (context, url) {
                  return Image.asset(
                    "assets/images/loading.gif",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            title: Text(
              post.owner.name.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
            subtitle: Text(
              post.when,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            trailing: post.owner.id == userBloc.user.id
                ? PopupMenuButton(
                    padding: EdgeInsets.all(10.0),
                    onSelected: (choice) {
                      choiceActions(choice, postBloc);
                    },
                    itemBuilder: (context) {
                      return ["Edit Post", "Delete Post"].map((choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: Text(
                            choice,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    icon: Icon(Icons.more_vert),
                  )
                : null,
          ),
        ),
        if (post.description != null)
          Container(
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.center,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              isThreeLine: false,
              title: Text(
                post.description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
          ),
        InkWell(
          onDoubleTap: () {
            return isLiked(userBloc, post.favorites)
                ? null
                : likePost(userBloc, postBloc);
          },
          child: Container(
            child: CachedNetworkImage(
              imageUrl: post.url,
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  isLiked(userBloc, post.favorites)
                      ? unlikePost(userBloc, postBloc)
                      : likePost(userBloc, postBloc);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                  child: Icon(
                    Icons.favorite,
                    color: isLiked(userBloc, post.favorites)
                        ? Colors.pink
                        : Colors.grey,
                    size: 26.0,
                  ),
                ),
              ),
              Expanded(child: Container()),
              getRedeemButton(userBloc, postBloc),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeList.show_likes,
              arguments: {
                "likes": post.favorites,
                "guestUser": widget.guestUser,
              },
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              "${post.favorites.length.toString()} ${post.favorites.length > 1 ? 'likes' : 'like'}",
              style: TextStyle(
                fontFamily: Fonts.titilliumWebSemiBold,
                fontSize: 18.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        if (userBloc.user.id == post.owner.id)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text(
              "1 Like = 1 Point",
              style: TextStyle(
                fontFamily: Fonts.titilliumWebRegular,
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
          ),
      ],
    );
  }

  bool isLiked(UserBloc userBloc, List<Favorite> favorites) {
    return favorites
        .map((favorite) => favorite.user.id)
        .contains(userBloc.user.id);
  }

  choiceActions(String choice, PostBloc postBloc) {
    if (choice == "Edit Post") {
      Navigator.pushNamed(
        context,
        routeList.manage_post,
        arguments: {
          "post": widget.post,
        },
      ).then((postData) {
        if (postData != null) {
          setState(() {
            post = postData;
          });
        }
      });
    }

    if (choice == "Delete Post") {
      showConfirmationPopup(
        context,
        message: "Delete This Post ?",
        onPressYes: () {
          deletePost(postBloc);
        },
      );
    }
  }

  void deletePost(postBloc) async {
    XsProgressHud.show(context);
    await postBloc.deletePost(post.id);
    XsProgressHud.hide();

    Navigator.pop(context);
  }

  void likePost(UserBloc userBloc, PostBloc postBloc) {
    Post postData = post
      ..favorites.add(Favorite.fromMap({
        "postId": post.id,
        "user": userBloc.user,
      }));

    setState(() {
      post = postData;
    });

    postBloc.toggleFavorite(widget.post.id);
  }

  void unlikePost(UserBloc userBloc, PostBloc postBloc) {
    Post postData = post
      ..favorites
          .removeWhere((favorite) => favorite.user.id == userBloc.user.id);

    setState(() {
      post = postData;
    });

    postBloc.toggleFavorite(widget.post.id);
  }

  void redeemPoints(PostBloc postBloc) async {
    XsProgressHud.show(context);

    final Post postData = await postBloc.redeemPoints(widget.post.id);

    setState(() {
      post = postData;
    });

    XsProgressHud.hide();
  }

  getRedeemButton(userBloc, postBloc) {
    if (post.earnings != null) {
      return Container(
        margin: EdgeInsets.all(10.0),
        child: Text(
          "Redeemed @ ${post.earnings['points']} likes",
          style: TextStyle(fontFamily: Fonts.titilliumWebRegular),
        ),
      );
    }

    if (userBloc.user.id == post.owner.id) {
      return Container(
        child: RaisedButton(
          color: Colors.blue,
          padding: EdgeInsets.all(0),
          onPressed: () {
            int minPoints = 20;

            if (post.favorites.length < minPoints) {
              showErrorPopup(
                context,
                message: "Minimum $minPoints likes required to redeem.",
              );
            } else {
              showConfirmationPopup(
                context,
                message: "You can only redeem once, are you sure ?",
                onPressYes: () {
                  redeemPoints(postBloc);
                },
              );
            }
          },
          child: Text(
            "Redeem",
            style: TextStyle(
              color: Colors.white,
              fontFamily: Fonts.titilliumWebSemiBold,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
