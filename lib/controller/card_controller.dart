import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart'; // Añadimos esta importación para BuildContext
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/card_model.dart' as card_model; // Añadimos el prefijo aquí
import '../provider/user_provider.dart';

class CardController {
  static const String _baseUrl =
      'http://10.0.2.2:9090'; //!cambiar cuando se haga APK

  static Future<List<card_model.Card>> getUserCards(
      BuildContext context) async {
    // Actualizamos el tipo
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // Agregamos logs para depuración
      developer
          .log('UserProvider state: ${userProvider.currentUser?.toJson()}');

      final userId =
          userProvider.currentUser?.id; // Cambiamos user por currentUser
      developer.log('User ID: $userId');

      if (userId == null) {
        developer.log('Usuario nulo en CardController');
        return []; // En lugar de lanzar excepción, retornamos lista vacía
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/cards/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          // Agrega aquí headers adicionales si son necesarios (como token)
        },
      );

      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> cardsJson = json.decode(response.body);
        // Agregamos log para ver la estructura exacta de cada tarjeta
        cardsJson.forEach((card) => developer.log('Card data: $card'));
        return cardsJson
            .map((json) => card_model.Card.fromJson(json))
            .toList(); // Actualizamos la referencia
      } else if (response.statusCode == 404) {
        // Retornamos una lista vacía en lugar de lanzar una excepción
        return [];
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Error en CardController',
          error: e, stackTrace: stackTrace);
      return []; // Retornamos lista vacía en caso de error
    }
  }

  static Future<card_model.Card> createCard(
      BuildContext context, card_model.Card card) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.currentUser?.id;

      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/cards'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(card.toJson()),
      );

      developer.log('Create card response: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return card_model.Card.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al crear la tarjeta: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Error creating card', error: e, stackTrace: stackTrace);
      throw Exception('Error en la conexión: $e');
    }
  }
}
