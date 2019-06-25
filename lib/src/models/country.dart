import 'package:meta/meta.dart';

@immutable
class Country {
  final int id;
  final String name;
  final String shortname;
  final String phonecode;

  Country({this.id, this.name, this.shortname, this.phonecode});

  Country copyWith(Map<String, dynamic> json) {
    return Country(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      shortname: json["shortname"] ?? this.shortname,
      phonecode: json["phonecode"] ?? this.phonecode,
    );
  }

  Country.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        shortname = json != null ? json["shortname"] : null,
        phonecode = json != null ? json["phonecode"] : null;

  static fromList(List countries) {
    List<Country> list = List<Country>();

    for (Map country in countries) {
      list.add(Country.fromMap(country));
    }

    return list;
  }
}
