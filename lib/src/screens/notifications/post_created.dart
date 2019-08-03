import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/notification.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/post.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/models/user_notification.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:timeago/timeago.dart' as timeago;

class PostCreated extends StatelessWidget {
  final UserNotification notification;

  PostCreated({
    Key key,
    @required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parsedDateTime = DateTime.parse(notification.createdAt);
    var ago = timeago.format(parsedDateTime);

    return Container(
      color: notification.readAt == null ? Colors.grey.shade200 : Colors.white,
      child: ListTile(
        dense: true,
        isThreeLine: false,
        onTap: () {
          markAsRead(notification);

          Navigator.pushNamed(
            context,
            routeList.view_profile,
            arguments: {
              "shouldPop": true,
              "user": User.fromMap(notification.data['user']),
            },
          );
        },
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: "$baseUrl/storage/${notification.data['user']['avatar']}",
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              notification.data['user']['name'],
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
            Container(width: 5.0),
            Text(
              "added a new post.",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
          ],
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            ago,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12.0,
              fontFamily: Fonts.titilliumWebRegular,
            ),
          ),
        ),
        trailing: InkWell(
          onTap: () {
            markAsRead(notification);

            Navigator.pushNamed(
              context,
              routeList.show_post,
              arguments: {
                "post": Post.fromMap(notification.data['post']),
                "guestUser": User.fromMap(notification.data['user']),
              },
            );
          },
          child: Image.network(
            "$baseUrl/storage/${notification.data['post']['url']}",
            width: 50.0,
          ),
        ),
      ),
    );
  }
}
