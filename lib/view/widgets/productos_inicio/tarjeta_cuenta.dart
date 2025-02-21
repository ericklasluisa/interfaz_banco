import 'package:flutter/material.dart';
import '../../../model/card_model.dart' as card_model;

class TarjetaCuenta extends StatelessWidget {
  final card_model.Card card;

  const TarjetaCuenta({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.indigo.shade900,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade600, width: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.cardType,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "******${card.number.substring(card.number.length - 4)}"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    card.isFrozen
                        ? const Icon(Icons.ac_unit,
                            color: Colors.blue, size: 18)
                        : Icon(Icons.star,
                            color: Colors.yellow.shade700, size: 18),
                    const SizedBox(width: 10),
                    Text(card.isFrozen ? "Congelada" : "Activa",
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade700)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Saldo Disponible",
                        style: TextStyle(fontSize: 12)),
                    Row(
                      children: [
                        Text("\$${card.balance.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Icon(Icons.remove_red_eye_rounded,
                            color: Colors.blue.shade800),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Vence\n${card.expiryMonth}/${card.expiryYear}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
