import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/models/profession.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String mobile;
  final String dob;
  final String gender;
  final Location location;
  final Profession profession;
  final int status;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.mobile,
    this.dob,
    this.gender,
    this.location,
    this.profession,
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
      location: json["location"] ?? this.location,
      profession: json["profession"] ?? this.profession,
      status: json["status"] ?? this.status,
    );
  }

  User.fromMap(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        avatar = json["avatar"],
        mobile = json["mobile"],
        dob = json["dob"],
        gender = json["gender"],
        location = json["location"] is Location
            ? json["location"]
            : Location.fromMap(json["location"]),
        profession = json["profession"] is Profession
            ? json["profession"]
            : Profession.fromMap(json["profession"]),
        status = json["status"];

  static fromList(List users) {
    List<User> list = List<User>();

    for (Map user in users) {
      list.add(User.fromMap(user));
    }

    return list;
  }
}
