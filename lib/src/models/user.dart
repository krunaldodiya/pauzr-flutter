import 'package:meta/meta.dart';
import 'package:pauzr/src/models/city.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/models/post.dart';
import 'package:pauzr/src/models/level.dart';
import 'package:pauzr/src/models/state.dart';
import 'package:pauzr/src/models/wallet.dart';

@immutable
class User {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String mobile;
  final String dob;
  final String gender;
  final Country country;
  final State state;
  final City city;
  final Level level;
  final Wallet wallet;
  final int status;
  final List followers;
  final List followings;
  final List<Post> posts;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.mobile,
    this.dob,
    this.gender,
    this.country,
    this.state,
    this.city,
    this.level,
    this.wallet,
    this.status,
    this.followers,
    this.followings,
    this.posts,
  });

  User copyWith(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      email: json["email"] ?? this.email,
      avatar: json["avatar"] ?? this.avatar,
      mobile: json["mobile"] ?? this.mobile,
      dob: json["dob"] ?? this.dob,
      gender: json["gender"] ?? this.gender,
      country: json["country"] ?? this.country,
      state: json["state"] ?? this.state,
      city: json["city"] ?? this.city,
      level: json["level"] ?? this.level,
      wallet: json["wallet"] ?? this.wallet,
      status: json["status"] ?? this.status,
      followers: json["followers"] ?? this.followers,
      followings: json["followings"] ?? this.followings,
      posts: json["posts"] ?? this.posts,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return User(
      id: json["id"] != null ? json["id"] : null,
      name: json["name"] != null ? json["name"] : null,
      email: json["email"] != null ? json["email"] : null,
      avatar: json["avatar"] != null ? json["avatar"] : null,
      mobile: json["mobile"] != null ? json["mobile"] : null,
      dob: json["dob"] != null ? json["dob"] : null,
      gender: json["gender"] != null ? json["gender"] : null,
      country: json["country"] != null
          ? json["country"] is Country
              ? json["country"]
              : Country.fromMap(json["country"])
          : null,
      state: json["state"] != null
          ? json["state"] is State
              ? json["state"]
              : State.fromMap(json["state"])
          : null,
      city: json["city"] != null
          ? json["city"] is City ? json["city"] : City.fromMap(json["city"])
          : null,
      level: json["level"] != null
          ? json["level"] is Level
              ? json["level"]
              : Level.fromMap(json["level"])
          : null,
      wallet: json["wallet"] != null
          ? json["wallet"] is Wallet
              ? json["wallet"]
              : Wallet.fromMap(json["wallet"])
          : null,
      status: json["status"] != null ? json["status"] : null,
      followers: json["followers"] != null ? json["followers"] : null,
      followings: json["followings"] != null ? json["followings"] : null,
      // followers: json["followers"] != null
      //     ? json["followers"] is List<Follower>
      //         ? json["followers"]
      //         : Follower.fromList(json["followers"])
      //     : null,
      // followings: json["followings"] != null
      //     ? json["followings"] is List<Following>
      //         ? json["followings"]
      //         : Following.fromList(json["followings"])
      //     : null,
    );
  }

  static fromList(List users) {
    List<User> list = List<User>();

    for (Map user in users) {
      list.add(User.fromMap(user));
    }

    return list;
  }
}
