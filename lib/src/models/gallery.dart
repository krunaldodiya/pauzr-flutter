import 'package:meta/meta.dart';

@immutable
class Gallery {
  final int id;
  final String type;
  final String url;

  Gallery({
    this.id,
    this.type,
    this.url,
  });

  Gallery copyWith(Map<String, dynamic> json) {
    return Gallery(
      id: json["id"] ?? this.id,
      type: json["type"] ?? this.type,
      url: json["url"] ?? this.url,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'] != null ? json["id"] : null,
      type: json['type'] != null ? json["type"] : null,
      url: json['url'] != null ? json["url"] : null,
    );
  }

  static fromList(List galleries) {
    List<Gallery> list = List<Gallery>();

    for (Map gallery in galleries) {
      list.add(Gallery.fromMap(gallery));
    }

    return list;
  }
}
