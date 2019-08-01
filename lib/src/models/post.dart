import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Post {
  final int id;
  final String type;
  final String url;
  final String description;
  final User owner;
  final List likes;
  final Map earnings;
  final String when;

  Post({
    this.id,
    this.type,
    this.url,
    this.description,
    this.owner,
    this.likes,
    this.earnings,
    this.when,
  });

  Post copyWith(Map<String, dynamic> json) {
    return Post(
      id: json["id"] ?? this.id,
      type: json["type"] ?? this.type,
      url: json["url"] ?? this.url,
      description: json["description"] ?? this.description,
      owner: json["owner"] ?? this.owner,
      likes: json["likes"] ?? this.likes,
      earnings: json["earnings"] ?? this.earnings,
      when: json["when"] ?? this.when,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Post(
      id: json['id'] != null ? json["id"] : null,
      type: json['type'] != null ? json["type"] : null,
      url: json['url'] != null ? json["url"] : null,
      description: json['description'] != null ? json["description"] : null,
      owner: json['owner'] != null
          ? json["owner"] is User ? json["owner"] : User.fromMap(json["owner"])
          : null,
      likes: json['likes'] != null ? json["likes"] : null,
      earnings: json['earnings'] != null ? json["earnings"] : null,
      when: json['when'] != null ? json["when"] : null,
    );
  }

  static fromList(List posts) {
    List<Post> list = List<Post>();

    for (Map post in posts) {
      list.add(Post.fromMap(post));
    }

    return list;
  }
}
