import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:provider/provider.dart';

class ShowLikesPage extends StatefulWidget {
  final List likes;

  ShowLikesPage({
    Key key,
    @required this.likes,
  }) : super(key: key);

  _ShowLikesPageState createState() => _ShowLikesPageState();
}

class _ShowLikesPageState extends State<ShowLikesPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

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
                  Map user = widget.likes[index]['user'];

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
                      subtitle: Text(
                        user['city']['name'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontFamily: Fonts.titilliumWebRegular,
                        ),
                      ),
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
}
