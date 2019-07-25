import 'package:meta/meta.dart';

@immutable
class Wallet {
  final int id;
  final int balance;

  Wallet({this.id, this.balance});

  Wallet copyWith(Map<String, dynamic> json) {
    return Wallet(
      id: json["id"] ?? this.id,
      balance: json["balance"] ?? this.balance,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Wallet(
      id: json["id"] != null ? json["id"] : null,
      balance: json['balance'] != null ? json["balance"] : null,
    );
  }
}
