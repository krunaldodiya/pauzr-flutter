import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class FollowPage extends StatefulWidget {
  final String type;
  final User guestUser;

  FollowPage({
    Key key,
    @required this.type,
    @required this.guestUser,
  }) : super(key: key);

  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  String keywords;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: 2);

    tabController.animateTo(
      widget.type == 'followers' ? 0 : 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    tabController.addListener(() {
      setState(() {
        keywords = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.addGroupParticipants.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.addGroupParticipants.appBackgroundColor,
        title: Container(
          alignment: Alignment.center,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            isThreeLine: false,
            title: Text(
              widget.guestUser.name.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          labelPadding: EdgeInsets.all(10.0),
          labelStyle: TextStyle(color: Colors.white),
          unselectedLabelColor: Colors.white.withOpacity(0.3),
          isScrollable: false,
          tabs: <Widget>[
            Text(
              "Followers (${widget.guestUser.followers.length})",
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            Text(
              "Following (${widget.guestUser.followings.length})",
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          showFollowList(
            widget.guestUser.followers
                .map((follower) => follower['follower_user'])
                .toList(),
            userBloc,
          ),
          showFollowList(
            widget.guestUser.followings
                .map((following) => following['following_user'])
                .toList(),
            userBloc,
          ),
        ],
      ),
    );
  }

  Column showFollowList(List users, UserBloc userBloc) {
    List filteredFollowList = users.where((contact) {
      if (keywords != null) {
        return contact['name'].toLowerCase().contains(keywords.toLowerCase());
      }

      return true;
    }).toList();

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      keywords = text;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Search",
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            primary: true,
            shrinkWrap: true,
            itemCount: filteredFollowList.length,
            itemBuilder: (context, index) {
              Map user = filteredFollowList?.elementAt(index);

              return Container(
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      routeList.view_profile,
                      arguments: {
                        "shouldPop": true,
                        "user": User.fromMap(user),
                      },
                    );
                  },
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrl/storage/${user['avatar']}",
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
                    user['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: Fonts.titilliumWebSemiBold,
                    ),
                  ),
                  subtitle: null,
                  trailing: getFollowButton(userBloc, user),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  getFollowButton(UserBloc userBloc, user) {
    if (userBloc.user.id == user['id']) return null;

    List followingIds = userBloc.user.followings
        .map((following) => following["following_user"]["id"])
        .toList();

    List followerIds = userBloc.user.followers
        .map((follower) => follower["follower_user"]['id'])
        .toList();

    bool alreadyFollowing = followingIds.contains(user["id"]);

    bool isFollower = followerIds.contains(user["id"]);

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
                  unfollowUser(userBloc, user["id"], widget.guestUser.id);
                },
              )
            : followUser(userBloc, user["id"], widget.guestUser.id);
      },
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
