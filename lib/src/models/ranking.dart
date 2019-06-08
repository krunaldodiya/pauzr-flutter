import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Ranking {
  final int rank;
  final int duration;
  final User user;

  Ranking({this.rank, this.duration, this.user});

  Ranking copyWith(Map<String, dynamic> json) {
    return Ranking(
      rank: json["rank"] ?? this.rank,
      duration: json["duration"] ?? this.duration,
      user: json["user"] ?? this.user,
    );
  }

  Ranking.fromMap(Map<String, dynamic> json)
      : rank = json != null ? json["rank"] : null,
        duration = json != null ? json["duration"] : null,
        user = json["user"] is User ? json["user"] : User.fromMap(json["user"]);

  static fromList(List rankings) {
    List<Ranking> list = List<Ranking>();

    for (Map ranking in rankings) {
      list.add(
        Ranking.fromMap({
          'rank': null,
          'duration': ranking['duration'],
          'user': ranking['user'],
        }),
      );
    }

    return list;
  }
}
