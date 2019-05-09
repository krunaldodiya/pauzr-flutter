import 'package:meta/meta.dart';

@immutable
class Profession {
  final int id;
  final String name;

  Profession({this.id, this.name});

  Profession copyWith(Map<String, dynamic> json) {
    return Profession(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
    );
  }

  Profession.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null;

  static fromList(List professions) {
    List<Profession> list = List<Profession>();

    for (Map profession in professions) {
      list.add(Profession.fromMap(profession));
    }

    return list;
  }
}
