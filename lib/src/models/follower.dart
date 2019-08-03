import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Follower {
  final int id;
  final int followerId;
  final int followingId;
  final User followerUser;

  Follower({
    this.id,
    this.followerId,
    this.followingId,
    this.followerUser,
  });

  Follower copyWith(Map<String, dynamic> json) {
    return Follower(
      id: json["id"] ?? this.id,
      followerId: json["follower_id"] ?? this.followerId,
      followingId: json["following_id"] ?? this.followingId,
      followerUser: json["follower_user"] ?? this.followerUser,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Follower(
      id: json["id"] != null ? json["id"] : null,
      followerId: json["follower_id"] != null ? json["follower_id"] : null,
      followingId: json["following_id"] != null ? json["following_id"] : null,
      followerUser: json['follower_user'] != null
          ? json["follower_user"] is User
              ? json["follower_user"]
              : User.fromMap(json["follower_user"])
          : null,
    );
  }

  static fromList(List followers) {
    List<Follower> list = List<Follower>();

    for (Map follower in followers) {
      list.add(Follower.fromMap(follower));
    }

    return list;
  }
}
