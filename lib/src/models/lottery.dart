import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Lottery {
  final int id;
  final int amount;
  final User user;

  Lottery({this.id, this.amount, this.user});

  Lottery copyWith(Map<String, dynamic> json) {
    return Lottery(
      id: json["id"] ?? this.id,
      amount: json["amount"] ?? this.amount,
      user: json["user"] ?? this.user,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Lottery(
      id: json["id"] != null ? json["id"] : null,
      amount: json["amount"] != null ? json["amount"] : null,
      user: json["user"] != null
          ? json["user"] is User ? json["user"] : User.fromMap(json["user"])
          : null,
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
