import 'package:flutter/material.dart';

class TiposOpciones extends StatelessWidget {
  const TiposOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3, // Número fijo de columnas
      mainAxisSpacing: 10, // Espacio vertical entre elementos
      crossAxisSpacing: 10, // Espacio horizontal entre elementos
      childAspectRatio:
          0.85, // Ajusta la proporción altura/anchura de cada tarjeta
      physics:
          const NeverScrollableScrollPhysics(), // Deshabilita el scroll del grid
      children: [
        _buildCard(Icons.credit_card, 'Transferir dinero'),
        _buildCard(Icons.payments_outlined, 'Recibir dinero'),
        _buildCard(Icons.qr_code_scanner_outlined, 'Escanear o mostar QR'),
        _buildCard(Icons.lightbulb_outline, 'Pagar servicios'),
        _buildCard(Icons.credit_score_outlined, 'Pagar tarjetas'),
        _buildCard(Icons.mobile_friendly_outlined, 'Retirar sin tarjeta'),
        _buildCard(Icons.phone, 'Recargar celular'),
        _buildCard(Icons.wallet_giftcard_outlined, 'Transferir un regalo'),
      ],
    );
  }

  Widget _buildCard(IconData icon, String text) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color.fromARGB(255, 116, 116, 116),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(255, 157, 157, 157), width: 0.1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
