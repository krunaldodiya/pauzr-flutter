import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Favorite {
  final int id;
  final int postId;
  final User user;

  Favorite({
    this.id,
    this.postId,
    this.user,
  });

  Favorite copyWith(Map<String, dynamic> json) {
    return Favorite(
      id: json["id"] ?? this.id,
      postId: json["postId"] ?? this.postId,
      user: json["user"] ?? this.user,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] != null ? json["id"] : null,
      postId: json['postId'] != null ? json["postId"] : null,
      user: json['user'] != null
          ? json["user"] is User ? json["user"] : User.fromMap(json["user"])
          : null,
    );
  }

  static fromList(List favorites) {
    List<Favorite> list = List<Favorite>();

    for (Map favorite in favorites) {
      list.add(Favorite.fromMap(favorite));
    }

    return list;
  }
}
