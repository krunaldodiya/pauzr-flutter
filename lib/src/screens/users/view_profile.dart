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
  User guestUser;
  List<Post> posts;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final PostBloc postBloc = Provider.of<PostBloc>(context);

    final User guestUserData = await userBloc.getGuestUser(widget.user.id);
    setState(() {
      guestUser = guestUserData;
    });

    await getPosts(postBloc, false, widget.user.id);

    _scrollController.addListener(() async {
      var pixels = _scrollController.position.pixels;
      var maxScrollExtent = _scrollController.position.maxScrollExtent;

      if (pixels == maxScrollExtent) {
        await getPosts(postBloc, true, widget.user.id);
      }
    });
  }

  Future getPosts(PostBloc postBloc, bool loadMore, int userId) async {
    final List<Post> postsData = await postBloc.getPosts(
      loadMore: false,
      userId: widget.user.id,
    );

    setState(() {
      posts = postsData;
    });
  }

  bool isLiked(UserBloc userBloc, List<Favorite> favorites) {
    return favorites
        .map((favorite) => favorite.user.id)
        .contains(userBloc.user.id);
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
    final PostBloc postBloc = Provider.of<PostBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  ).then((user) {
                    setState(() {
                      guestUser = user;
                    });

                    getPosts(postBloc, false, widget.user.id);
                  });
                },
              ),
              margin: EdgeInsets.only(right: 10.0),
            ),
        ],
      ),
      body: SafeArea(
        child: userBloc.loading == true ||
                postBloc.loading == true ||
                guestUser == null ||
                posts == null
            ? Center(child: CircularProgressIndicator())
            : getBody(context, postBloc, userBloc),
      ),
    );
  }

  Container getBody(
    BuildContext context,
    PostBloc postBloc,
    UserBloc userBloc,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5.0),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "$baseUrl/storage/${guestUser.avatar}",
                        placeholder: (context, url) {
                          return Image.asset(
                            "assets/images/loading.gif",
                            width: 70.0,
                            height: 70.0,
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Icon(Icons.error);
                        },
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            posts.length.toString(),
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          routeList.follow_page,
                          arguments: {
                            "type": "followers",
                            "guestUser": guestUser,
                          },
                        );
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              guestUser.followers.length.toString(),
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
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          routeList.follow_page,
                          arguments: {
                            "type": "followings",
                            "guestUser": guestUser,
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              guestUser.followings.length.toString(),
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
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0,
                  vertical: 5.0,
                ),
                width: double.infinity,
                child: userBloc.user.id == guestUser.id
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
                          Navigator.pushNamed(
                            context,
                            routeList.manage_post,
                            arguments: {"post": null},
                          );
                        },
                      )
                    : getFollowButton(userBloc),
              ),
            ]),
          ),
          getGridView(userBloc, postBloc),
        ],
      ),
    );
  }

  getFollowButton(UserBloc userBloc) {
    List followingIds = userBloc.user.followings
        .map((following) => following["following_user"]['id'])
        .toList();

    List followerIds = userBloc.user.followers
        .map((follower) => follower["follower_user"]['id'])
        .toList();

    bool alreadyFollowing = followingIds.contains(widget.user.id);

    bool isFollower = followerIds.contains(widget.user.id);

    return FlatButton(
      color: alreadyFollowing ? Colors.grey.shade300 : Colors.blue,
      child: Text(
        alreadyFollowing ? "Following" : isFollower ? "Follow Back" : "Follow",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: alreadyFollowing ? Colors.black : Colors.white,
        ),
      ),
      onPressed: () {
        alreadyFollowing
            ? showConfirmationPopup(
                context,
                message: "Are you sure want to unfollow ?",
                onPressYes: () {
                  unfollowUser(userBloc, guestUser.id, guestUser.id);
                },
              )
            : followUser(userBloc, guestUser.id, guestUser.id);
      },
    );
  }

  getGridView(UserBloc userBloc, PostBloc postBloc) {
    if (userBloc.loading == true || postBloc.loading == true) {
      return SliverList(
        delegate: SliverChildListDelegate([
          Container(
            margin: EdgeInsets.all(15.0),
            child: Text(
              "Loading...",
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

    if (posts.length == 0) {
      return SliverList(
        delegate: SliverChildListDelegate([
          Container(
            margin: EdgeInsets.all(15.0),
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
          Post post = posts[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                routeList.show_post,
                arguments: {
                  "post": post,
                  "guestUser": guestUser,
                },
              ).then((post) {
                getPosts(postBloc, false, widget.user.id);
              });
            },
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrl/storage/${post.url}",
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
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.favorite,
                      color: isLiked(userBloc, post.favorites)
                          ? Colors.pink
                          : Colors.white,
                      size: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: posts.length,
      ),
    );
  }

  void followUser(UserBloc userBloc, int followingId, int guestId) async {
    XsProgressHud.show(context);
    await userBloc.followUser(followingId, guestId);
    XsProgressHud.hide();
  }

  void unfollowUser(UserBloc userBloc, int followingId, int guestId) async {
    XsProgressHud.show(context);
    await userBloc.unfollowUser(followingId, guestId);
    XsProgressHud.hide();
  }
}
