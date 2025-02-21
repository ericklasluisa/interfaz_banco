import 'payment_model.dart';

class Transaction {
  final int? id;
  final int cardId;
  final double amount;
  final String type;
  final String status;
  final Payment? payment;

  Transaction({
    this.id,
    required this.cardId,
    required this.amount,
    required this.type,
    required this.status,
    this.payment,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      cardId: json['card_id'],
      amount: json['amount']?.toDouble() ?? 0.0,
      type: json['type'],
      status: json['status'],
      payment:
          json['payment'] != null ? Payment.fromJson(json['payment']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'card_id': cardId,
        'amount': amount,
        'type': type,
        'status': status,
        'payment': payment?.toJson(),
      };

  Transaction copyWith({
    int? id,
    int? cardId,
    double? amount,
    String? type,
    String? status,
    Payment? payment,
  }) {
    return Transaction(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      payment: payment ?? this.payment,
    );
  }
}
