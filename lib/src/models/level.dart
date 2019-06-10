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

  Level.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        level = json != null ? json["level"] : null,
        points = json != null ? json["points"] : null;
}
