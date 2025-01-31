import 'package:flutter/material.dart';
import 'package:pauzr/follow.dart';
import 'package:pauzr/invite.dart';
import 'package:pauzr/show_likes.dart';
import 'package:pauzr/src/routes/list.dart' as routeList;
import 'package:pauzr/src/screens/earnings.dart';
import 'package:pauzr/src/screens/group/add_group_participants.dart';
import 'package:pauzr/src/screens/group/detail.dart';
import 'package:pauzr/src/screens/group/group_scoreboard.dart';
import 'package:pauzr/src/screens/group/manage_group.dart';
import 'package:pauzr/src/screens/initial_screen.dart';
import 'package:pauzr/src/screens/intro.dart';
import 'package:pauzr/src/screens/levels/info.dart';
import 'package:pauzr/src/screens/lottery_page.dart';
import 'package:pauzr/src/screens/manage_theme.dart';
import 'package:pauzr/src/screens/minutes/info.dart';
import 'package:pauzr/src/screens/otp/request_otp.dart';
import 'package:pauzr/src/screens/otp/verify_otp.dart';
import 'package:pauzr/src/screens/points/info.dart';
import 'package:pauzr/src/screens/posts/manage_post.dart';
import 'package:pauzr/src/screens/show_photo.dart';
import 'package:pauzr/src/screens/show_post.dart';
import 'package:pauzr/src/screens/stop.dart';
import 'package:pauzr/src/screens/tabs.dart';
import 'package:pauzr/src/screens/tabs/group.dart';
import 'package:pauzr/src/screens/users/edit_profile.dart';
import 'package:pauzr/src/screens/users/profile/choose_city.dart';
import 'package:pauzr/src/screens/users/profile/choose_country.dart';
import 'package:pauzr/src/screens/users/profile/choose_gender.dart';
import 'package:pauzr/src/screens/users/view_profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map args = settings.arguments;

    switch (settings.name) {
      case routeList.home:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
        break;

      case routeList.tab:
        return MaterialPageRoute(
          builder: (context) {
            return TabsPage();
          },
        );
        break;

      case routeList.intro:
        return MaterialPageRoute(
          builder: (context) {
            return IntroPage();
          },
        );
        break;

      case routeList.follow_page:
        return MaterialPageRoute(
          builder: (context) {
            return FollowPage(
              type: args['type'],
              guestUser: args['guestUser'],
            );
          },
        );
        break;

      case routeList.manage_theme:
        return MaterialPageRoute(
          builder: (context) {
            return ManageTheme();
          },
        );
        break;

      case routeList.group_scoreboard:
        return MaterialPageRoute(
          builder: (context) {
            return GroupScoreboardPage(
              group: args['group'],
            );
          },
        );
        break;

      case routeList.group_detail:
        return MaterialPageRoute(
          builder: (context) {
            return GroupDetailPage(
              group: args['group'],
            );
          },
        );
        break;

      case routeList.request_otp:
        return MaterialPageRoute(
          builder: (context) {
            return RequestOtpPage();
          },
        );
        break;

      case routeList.verify_otp:
        return MaterialPageRoute(
          builder: (context) {
            return VerifyOtpPage();
          },
        );
        break;

      case routeList.show_photo:
        return MaterialPageRoute(
          builder: (context) {
            return ShowPhoto(photo: args['photo']);
          },
        );
        break;

      case routeList.show_post:
        return MaterialPageRoute(
          builder: (context) {
            return ShowPost(
              post: args['post'],
              guestUser: args['guestUser'],
            );
          },
        );
        break;

      case routeList.show_likes:
        return MaterialPageRoute(
          builder: (context) {
            return ShowLikesPage(
              likes: args['likes'],
              guestUser: args['guestUser'],
            );
          },
        );
        break;

      case routeList.edit_profile:
        if (args['shouldPop'] is bool) {
          return MaterialPageRoute(
            builder: (context) {
              return EditProfilePage(
                shouldPop: args['shouldPop'],
              );
            },
          );
        }

        return _errorRoute();
        break;

      case routeList.view_profile:
        return MaterialPageRoute(
          builder: (context) {
            return ViewProfilePage(
              shouldPop: args['shouldPop'],
              user: args['user'],
            );
          },
        );
        break;

      case routeList.stop:
        return MaterialPageRoute(
          builder: (context) {
            return StopPage(duration: args['duration']);
          },
        );
        break;

      case routeList.levels:
        return MaterialPageRoute(
          builder: (context) {
            return LevelsPage();
          },
        );
        break;

      case routeList.points:
        return MaterialPageRoute(
          builder: (context) {
            return PointsPage();
          },
        );
        break;

      case routeList.minutes:
        return MaterialPageRoute(
          builder: (context) {
            return MinutesPage();
          },
        );
        break;

      case routeList.gender:
        return MaterialPageRoute(
          builder: (context) {
            return ChooseGender();
          },
        );
        break;

      case routeList.manage_group:
        return MaterialPageRoute(
          builder: (context) {
            return ManageGroupPage(group: args['group']);
          },
        );
        break;

      case routeList.manage_post:
        return MaterialPageRoute(
          builder: (context) {
            return ManagePostPage(post: args['post']);
          },
        );
        break;

      case routeList.add_group_participants:
        return MaterialPageRoute(
          builder: (context) {
            return AddGroupParticipantsPage(
              group: args['group'],
              shouldPop: args['shouldPop'],
            );
          },
        );
        break;

      case routeList.invite:
        return MaterialPageRoute(
          builder: (context) {
            return InvitePage();
          },
        );
        break;

      case routeList.lottery:
        return MaterialPageRoute(
          builder: (context) {
            return LotteryPage();
          },
        );
        break;

      case routeList.earnings:
        return MaterialPageRoute(
          builder: (context) {
            return EarningsPage();
          },
        );
        break;

      case routeList.city_list:
        return MaterialPageRoute(
          builder: (context) {
            return ChooseCity();
          },
        );
        break;

      case routeList.country_list:
        return MaterialPageRoute(
          builder: (context) {
            return ChooseCountry();
          },
        );
        break;

      case routeList.initial_screen:
        return MaterialPageRoute(
          builder: (context) {
            return InitialScreen(authToken: args['authToken']);
          },
        );
        break;

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(body: Center(child: Text("Error")));
    },
  );
}
