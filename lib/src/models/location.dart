import 'package:meta/meta.dart';

@immutable
class Location {
  final int id;
  final String city;
  final String state;

  Location({this.id, this.city, this.state});

  Location copyWith(Map<String, dynamic> json) {
    return Location(
      id: json["id"] ?? this.id,
      city: json["city"] ?? this.city,
      state: json["state"] ?? this.state,
    );
  }

  Location.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        city = json != null ? json["city"] : null,
        state = json != null ? json["state"] : null;

  static fromList(List locations) {
    List<Location> list = List<Location>();

    for (Map location in locations) {
      list.add(Location.fromMap(location));
    }

    return list;
  }
}
