import 'package:meta/meta.dart';

@immutable
class WalletTransaction {
  final int id;
  final int userId;
  final int walletId;
  final int amount;
  final Map meta;
  final String createdAt;
  final String updatedAt;

  WalletTransaction({
    this.id,
    this.userId,
    this.walletId,
    this.amount,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  WalletTransaction copyWith(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json["id"] ?? this.id,
      userId: json["user_id"] ?? this.userId,
      walletId: json["wallet_id"] ?? this.walletId,
      amount: json["amount"] ?? this.amount,
      meta: json["meta"] ?? this.meta,
      createdAt: json["created_at"] ?? this.createdAt,
      updatedAt: json["updated_at"] ?? this.updatedAt,
    );
  }

  WalletTransaction.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        userId = json != null ? json["user_id"] : null,
        walletId = json != null ? json["wallet_id"] : null,
        amount = json != null ? json["amount"] : null,
        meta = json != null ? json["meta"] : null,
        createdAt = json != null ? json["created_at"] : null,
        updatedAt = json != null ? json["updated_at"] : null;

  static fromList(List walletHistory) {
    List<WalletTransaction> list = List<WalletTransaction>();

    for (Map wh in walletHistory) {
      list.add(WalletTransaction.fromMap(wh));
    }

    return list;
  }
}
