import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../model/transaction_model.dart';

class TransactionController {
  static const String _baseUrl = 'http://10.40.16.114:9090';

  static Future<List<Transaction>> getCardTransactions(int cardId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/transactions'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      developer.log('Get transactions response: ${response.statusCode}');
      developer.log('Get transactions body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> transactionsJson = json.decode(response.body);
        final allTransactions =
            transactionsJson.map((json) => Transaction.fromJson(json)).toList();

        // Filtrar solo las transacciones del cardId específico
        return allTransactions.where((t) => t.cardId == cardId).toList();
      } else {
        throw Exception(
            'Error al obtener transacciones: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Error getting transactions',
          error: e, stackTrace: stackTrace);
      throw Exception('Error en la conexión: $e');
    }
  }
}
