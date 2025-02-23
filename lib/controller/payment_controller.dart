import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../model/payment_model.dart';
import './card_controller.dart';

class PaymentController {
  static const String _baseUrl = 'http://10.0.2.2:9090';

  static Future<Payment> makePayment(
      int sourceCardId, String destinationCardNumber, double amount) async {
    try {
      // Primero buscamos la tarjeta destino
      final destinationCard =
          await CardController.findCardByNumber(destinationCardNumber);

      if (destinationCard == null) {
        throw Exception('Tarjeta destino no encontrada');
      }

      // Creamos el objeto Payment con el ID de la tarjeta destino
      final payment = Payment(
        emitCardId: sourceCardId,
        receptorCardId: destinationCard.id!,
        amount: amount,
        status: 'EXITOSO',
      );

      final response = await http.post(
        Uri.parse('$_baseUrl/payments'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payment.toJson()),
      );

      developer.log('Payment response: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Payment.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al realizar el pago: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Error making payment', error: e, stackTrace: stackTrace);
      throw Exception('Error en la conexión: $e');
    }
  }
}
