import 'package:meta/meta.dart';

@immutable
class Group {
  final int id;
  final String name;
  final String photo;

  Group({this.id, this.name, this.photo});

  Group copyWith(Map<String, dynamic> json) {
    return Group(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      photo: json["photo"] ?? this.photo,
    );
  }

  Group.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        photo = json != null ? json["photo"] : null;

  static fromList(List groups) {
    List<Group> list = List<Group>();

    for (Map group in groups) {
      list.add(Group.fromMap(group));
    }

    return list;
  }
}
