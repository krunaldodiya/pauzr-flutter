import 'package:meta/meta.dart';

@immutable
class Level {
  final int id;
  final int level;
  final int points;

  Level({this.id, this.level, this.points});

  Level copyWith(Map<String, dynamic> json) {
    return Level(
      id: json["id"] ?? this.id,
      level: json["level"] ?? this.level,
      points: json["points"] ?? this.points,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Level(
      id: json["id"] != null ? json["id"] : null,
      level: json['level'] != null ? json["level"] : null,
      points: json['points'] != null ? json["points"] : null,
    );
  }
}
