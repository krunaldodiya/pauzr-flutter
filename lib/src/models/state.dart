import 'package:meta/meta.dart';

@immutable
class State {
  final int id;
  final String name;

  State({this.id, this.name});

  State copyWith(Map<String, dynamic> json) {
    return State(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return State(
      id: json['id'] != null ? json["id"] : null,
      name: json['name'] != null ? json["name"] : null,
    );
  }

  static fromList(List states) {
    List<State> list = List<State>();

    for (Map state in states) {
      list.add(State.fromMap(state));
    }

    return list;
  }
}
