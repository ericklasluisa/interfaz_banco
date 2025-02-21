import 'package:interfaz_banco/model/card_model.dart';

class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final List<Card>? cards;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.cards,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      cards: json['cards'] != null
          ? List<Card>.from(json['cards'].map((x) => Card.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'cards': cards?.map((x) => x.toJson()).toList(),
      };

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    List<Card>? cards,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      cards: cards ?? this.cards,
    );
  }
}
