import 'user_model.dart';

class Card {
  final int? id;
  final String number;
  final int creationYear;
  final int expiryYear;
  final int expiryMonth;
  final String cvv;
  final String cardType;
  final bool isFrozen;
  final String pin;
  final double balance;
  final User? user;

  Card({
    this.id,
    required this.number,
    required this.creationYear,
    required this.expiryYear,
    required this.expiryMonth,
    required this.cvv,
    required this.cardType,
    required this.isFrozen,
    required this.pin,
    required this.balance,
    this.user,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      number: json['number'],
      creationYear: json['creationYear'],
      expiryYear: json['expiryYear'],
      expiryMonth: json['expiryMonth'],
      cvv: json['cvv'],
      cardType: json['cardType'],
      isFrozen:
          json['isFrozen'] ?? json['frozen'] ?? false, // Modificamos esta línea
      pin: json['pin'],
      balance: json['balance']?.toDouble() ?? 0.0,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'creationYear': creationYear,
        'expiryYear': expiryYear,
        'expiryMonth': expiryMonth,
        'cvv': cvv,
        'cardType': cardType,
        'frozen': isFrozen, // Cambiamos isFrozen por frozen al enviar
        'pin': pin,
        'balance': balance,
        'user': user?.toJson(),
      };

  Card copyWith({
    int? id,
    String? number,
    int? creationYear,
    int? expiryYear,
    int? expiryMonth,
    String? cvv,
    String? cardType,
    bool? isFrozen,
    String? pin,
    double? balance,
    User? user,
  }) {
    return Card(
      id: id ?? this.id,
      number: number ?? this.number,
      creationYear: creationYear ?? this.creationYear,
      expiryYear: expiryYear ?? this.expiryYear,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      cvv: cvv ?? this.cvv,
      cardType: cardType ?? this.cardType,
      isFrozen: isFrozen ?? this.isFrozen,
      pin: pin ?? this.pin,
      balance: balance ?? this.balance,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Card && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
