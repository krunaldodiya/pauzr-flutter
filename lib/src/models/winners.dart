import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Winner {
  final int rank;
  final int duration;
  final User user;

  Winner({this.rank, this.duration, this.user});

  Winner copyWith(Map<String, dynamic> json) {
    return Winner(
      rank: json["rank"] ?? this.rank,
      duration: json["duration"] ?? this.duration,
      user: json["user"] ?? this.user,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Winner(
      rank: json['rank'] != null ? json["rank"] : null,
      duration: json['duration'] != null ? json["duration"] : null,
      user: json['user'] != null
          ? json["user"] is User ? json["user"] : User.fromMap(json["user"])
          : null,
    );
  }

  static fromList(List winners) {
    List<Winner> list = List<Winner>();

    for (Map winner in winners) {
      list.add(
        Winner.fromMap({
          'rank': null,
          'duration': winner['duration'],
          'user': winner['user'],
        }),
      );
    }

    return list;
  }
}
