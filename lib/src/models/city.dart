import 'package:meta/meta.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/models/state.dart';

@immutable
class City {
  final int id;
  final String name;
  final State state;
  final Country country;

  City({this.id, this.name, this.state, this.country});

  City copyWith(Map<String, dynamic> json) {
    return City(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      country: json["country"] ?? this.country,
    );
  }

  City.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        state = json["state"] is State
            ? json["state"]
            : State.fromMap(json["state"]),
        country = json["country"] is Country
            ? json["country"]
            : Country.fromMap(json["country"]);

  static fromList(List cities) {
    List<City> list = List<City>();

    for (Map city in cities) {
      list.add(City.fromMap(city));
    }

    return list;
  }
}
