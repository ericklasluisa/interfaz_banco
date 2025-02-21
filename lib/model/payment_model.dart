import 'transaction_model.dart';

class Payment {
  final int? id;
  final int emitCardId;
  final int receptorCardId;
  final double amount;
  final String status;
  final List<Transaction>? transactions;

  Payment({
    this.id,
    required this.emitCardId,
    required this.receptorCardId,
    required this.amount,
    required this.status,
    this.transactions,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      emitCardId: json['emit_card_id'],
      receptorCardId: json['receptor_card_id'],
      amount: json['amount']?.toDouble() ?? 0.0,
      status: json['status'],
      transactions: json['transactions'] != null
          ? List<Transaction>.from(
              json['transactions'].map((x) => Transaction.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'emit_card_id': emitCardId,
        'receptor_card_id': receptorCardId,
        'amount': amount,
        'status': status,
        'transactions': transactions?.map((x) => x.toJson()).toList(),
      };

  Payment copyWith({
    int? id,
    int? emitCardId,
    int? receptorCardId,
    double? amount,
    String? status,
    List<Transaction>? transactions,
  }) {
    return Payment(
      id: id ?? this.id,
      emitCardId: emitCardId ?? this.emitCardId,
      receptorCardId: receptorCardId ?? this.receptorCardId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }
}
