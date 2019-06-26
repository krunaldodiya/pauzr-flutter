import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/models/level.dart';
import 'package:pauzr/src/models/city.dart';
import 'package:meta/meta.dart';
import 'package:pauzr/src/models/state.dart';

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
  final int status;

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
    this.status,
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
      status: json["status"] ?? this.status,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return User(
      id: json["id"] != null ? json["id"] : null,
      name: json["name"] != null ? json["name"] : null,
      email: json["email"] != null ? json["email"] : null,
      avatar: json["avatar"] != null ? json["avatar"] : null,
      mobile: json["mobile"] != null ? json["mobile"] : null,
      dob: json["dob"] != null ? json["id"] : null,
      gender: json["gender"] != null ? json["id"] : null,
      // country: json["country"] != null
      //     ? json["country"] is Country
      //         ? json["country"]
      //         : Country.fromMap(json["country"])
      //     : null,
      // state: json["state"] != null
      //     ? json["state"] is State
      //         ? json["state"]
      //         : State.fromMap(json["state"])
      //     : null,
      // city: json["city"] != null
      //     ? json["city"] is City ? json["city"] : City.fromMap(json["city"])
      //     : null,
      country: null,
      state: null,
      city: null,
      level: json["level"] != null
          ? json["level"] is Level
              ? json["level"]
              : Level.fromMap(json["level"])
          : null,
      status: json["status"] != null ? json["status"] : null,
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
