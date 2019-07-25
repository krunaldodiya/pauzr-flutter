import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Lottery {
  final int id;
  final int amount;
  final User user;
  final String createdAt;
  final String updatedAt;

  Lottery({
    this.id,
    this.amount,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  Lottery copyWith(Map<String, dynamic> json) {
    return Lottery(
      id: json["id"] ?? this.id,
      amount: json["amount"] ?? this.amount,
      user: json["user"] ?? this.user,
      createdAt: json["created_at"] ?? this.createdAt,
      updatedAt: json["updated_at"] ?? this.updatedAt,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Lottery(
      id: json["id"] != null ? json["id"] : null,
      amount: json["amount"] != null ? json["amount"] : null,
      user: json["user"] != null
          ? json["user"] is User ? json["user"] : User.fromMap(json["user"])
          : null,
      createdAt: json["created_at"] != null ? json["created_at"] : null,
      updatedAt: json["updated_at"] != null ? json["updated_at"] : null,
    );
  }

  static fromList(List lotteries) {
    List<Lottery> list = List<Lottery>();

    for (Map lottery in lotteries) {
      list.add(Lottery.fromMap(lottery));
    }

    return list;
  }
}
