import 'package:meta/meta.dart';
import 'package:pauzr/src/models/city.dart';

@immutable
class Timer {
  final int id;
  final int userId;
  final City city;
  final String duration;
  final String createdAt;
  final String updatedAt;

  Timer({
    this.id,
    this.userId,
    this.city,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  Timer copyWith(Map<String, dynamic> json) {
    return Timer(
      id: json["id"] ?? this.id,
      userId: json["user_id"] ?? this.userId,
      city: json["city"] ?? this.city,
      duration: json["duration"] ?? this.duration,
      createdAt: json["created_at"] ?? this.createdAt,
      updatedAt: json["updated_at"] ?? this.updatedAt,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Timer(
      id: json["id"] != null ? json["id"] : null,
      userId: json["user_id"] != null ? json["user_id"] : null,
      city: json["city"] != null
          ? json["city"] is City ? json["city"] : City.fromMap(json["city"])
          : null,
      duration: json["duration"] != null ? json["duration"] : null,
      createdAt: json["created_at"] != null ? json["created_at"] : null,
      updatedAt: json["updated_at"] != null ? json["updated_at"] : null,
    );
  }

  static fromList(List timerHistory) {
    List<Timer> list = List<Timer>();

    for (Map th in timerHistory) {
      list.add(Timer.fromMap(th));
    }

    return list;
  }
}
