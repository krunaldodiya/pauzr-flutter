import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/favorite.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class ShowLikesPage extends StatefulWidget {
  final List<Favorite> likes;
  final User guestUser;

  ShowLikesPage({
    Key key,
    @required this.likes,
    @required this.guestUser,
  }) : super(key: key);

  _ShowLikesPageState createState() => _ShowLikesPageState();
}

class _ShowLikesPageState extends State<ShowLikesPage>
    with SingleTickerProviderStateMixin {
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
              "Likes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                primary: true,
                shrinkWrap: true,
                itemCount: widget.likes.length,
                itemBuilder: (context, index) {
                  final User user = widget.likes[index].user;

                  return Container(
                    color: Colors.white,
                    child: ListTile(
                      dense: true,
                      isThreeLine: false,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          routeList.view_profile,
                          arguments: {
                            "shouldPop": true,
                            "user": user,
                          },
                        );
                      },
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "$baseUrl/storage/${user.avatar}",
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
                        user.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: Fonts.titilliumWebSemiBold,
                        ),
                      ),
                      subtitle: Text(
                        user.city.name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
                      trailing: getFollowButton(userBloc, user),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getFollowButton(UserBloc userBloc, user) {
    if (userBloc.user.id == user.id) return null;

    List followingIds = userBloc.user.followings
        .map((following) => following.followingId)
        .toList();

    List followerIds =
        userBloc.user.followers.map((follower) => follower.followerId).toList();

    bool alreadyFollowing = followingIds.contains(user.id);

    bool isFollower = followerIds.contains(user.id);

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
                  unfollowUser(userBloc, user.id, widget.guestUser.id);
                },
              )
            : followUser(userBloc, user.id, widget.guestUser.id);
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
