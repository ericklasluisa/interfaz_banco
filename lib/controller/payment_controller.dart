import 'dart:convert';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:interfaz_banco/notifications/enviar_notificaciones_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../model/payment_model.dart';
import './card_controller.dart';

class PaymentController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final EnviarNotificacionService _enviarNotificacionService =
      EnviarNotificacionService();

  static const String _baseUrl = 'http://10.0.2.2:9090';

  Future<Payment> makePayment(BuildContext context, int sourceCardId,
      String destinationCardNumber, double amount) async {
    try {
      // Obtener el nombre del usuario remitente desde el provider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final remitenteName = userProvider.currentUser?.username ?? 'Usuario';

      // Primero buscamos la tarjeta destino
      final destinationCard =
          await CardController.findCardByNumber(destinationCardNumber);

      if (destinationCard == null) {
        throw Exception('Tarjeta destino no encontrada');
      }

      final destinationUserEmail =
          await CardController.findUserByCard(destinationCard.id!);

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
        // Enviar notificación
        await obtenerYEnviarNotificacion(
          receptor: destinationUserEmail!,
          remitente: remitenteName,
          texto:
              'Has recibido una transferencia de \$${amount.toStringAsFixed(2)}',
        );

        return Payment.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al realizar el pago: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Error making payment', error: e, stackTrace: stackTrace);
      throw Exception('Error en la conexión: $e');
    }
  }

  Future<void> obtenerYEnviarNotificacion({
    required String receptor,
    required String remitente,
    required String texto,
  }) async {
    try {
      // Buscar el token en Firestore
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: receptor)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String? token =
            querySnapshot.docs.first['notificationToken'] as String?;

        if (token != null) {
          // Enviar la notificación
          final resultado = await _enviarNotificacionService.pushNotifications(
              title: "Transferencia recibida de $remitente",
              body: texto,
              token: token);

          if (resultado) {
            print("Notificación enviada a $receptor");
          } else {
            print("Error de petición");
          }
        } else {
          print("El usuario con email $receptor no tiene un notificationToken");
        }
      } else {
        print("No se encontró el usuario con el email $receptor");
      }
    } catch (e) {
      print("Error en el proceso: $e");
    }
  }
}
