import 'package:flutter/material.dart';

class TiposOpciones extends StatelessWidget {
  const TiposOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        spacing: 10, // Espacio horizontal entre tarjetas
        runSpacing: 10, // Espacio vertical entre filas
        alignment: WrapAlignment.start,
        children: [
          _buildCard(Icons.credit_card, 'Transferir dinero'),
          _buildCard(Icons.credit_card, 'Pagar servicios'),
          _buildCard(Icons.phone, 'Recargar celular'),
          _buildCard(Icons.shopping_cart, 'Compras'),
          _buildCard(Icons.payment, 'Pagar crédito'),
          _buildCard(Icons.account_balance, 'Estado de cuenta'),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String text) {
    return SizedBox(
      width: 100, // Ancho fijo para que las tarjetas se distribuyan correctamente
      child: Card(
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
      ),
    );
  }
}
