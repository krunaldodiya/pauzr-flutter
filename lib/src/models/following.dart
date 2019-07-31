import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Following {
  final List users;

  Following({this.users});

  Following copyWith(Map<String, dynamic> json) {
    return Following(
      users: json["follower_user"] ?? this.users,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Following(
      users: json['follower_user'] != null
          ? json["follower_user"] is User
              ? json["follower_user"]
              : User.fromMap(json["follower_user"])
          : null,
    );
  }

  static fromList(List followings) {
    List list = List();

    for (Map following in followings) {
      list.add(following['following_user']);
    }

    return list;
  }
}
