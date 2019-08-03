import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Following {
  final int id;
  final int followerId;
  final int followingId;
  final User followingUser;

  Following({
    this.id,
    this.followerId,
    this.followingId,
    this.followingUser,
  });

  Following copyWith(Map<String, dynamic> json) {
    return Following(
      id: json["id"] ?? this.id,
      followerId: json["follower_id"] ?? this.followerId,
      followingId: json["following_id"] ?? this.followingId,
      followingUser: json["following_user"] ?? this.followingUser,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Following(
      id: json["id"] != null ? json["id"] : null,
      followerId: json["follower_id"] != null ? json["follower_id"] : null,
      followingId: json["following_id"] != null ? json["following_id"] : null,
      followingUser: json['following_user'] != null
          ? json["following_user"] is User
              ? json["following_user"]
              : User.fromMap(json["following_user"])
          : null,
    );
  }

  static fromList(List followings) {
    List<Following> list = List<Following>();

    for (Map following in followings) {
      list.add(Following.fromMap(following));
    }

    return list;
  }
}
