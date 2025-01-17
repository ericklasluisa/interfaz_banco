import 'package:flutter/material.dart';

class TarjetaCuenta extends StatelessWidget {
  const TarjetaCuenta({super.key});

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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AHO419",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("******7419"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text("Cta. favorita",
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
                        const Text("\$100.89",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.blue.shade800,
                        ),
                      ],
                    ),
                  ],
                ),
                const Text(
                  "Cuenta\nTransaccional",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
