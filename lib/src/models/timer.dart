import 'package:meta/meta.dart';

@immutable
class Timer {
  final int id;
  final int userId;
  final int locationId;
  final String duration;
  final String createdAt;
  final String updatedAt;

  Timer({
    this.id,
    this.userId,
    this.locationId,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  Timer copyWith(Map<String, dynamic> json) {
    return Timer(
      id: json["id"] ?? this.id,
      userId: json["user_id"] ?? this.userId,
      locationId: json["location_id"] ?? this.locationId,
      duration: json["duration"] ?? this.duration,
      createdAt: json["created_at"] ?? this.createdAt,
      updatedAt: json["updated_at"] ?? this.updatedAt,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Timer(
      id: json["id"] != null ? json["id"] : null,
      userId: json["user_id"] != null ? json["user_id"] : null,
      locationId: json["location_id"] != null ? json["location_id"] : null,
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
