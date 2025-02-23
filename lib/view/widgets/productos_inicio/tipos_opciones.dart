import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/pages/transfer_money_page.dart';

class TiposOpciones extends StatelessWidget {
  final VoidCallback? onTransferComplete; // Agregamos callback

  const TiposOpciones({super.key, this.onTransferComplete});

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
        _buildCard(
          icon: Icons.credit_card,
          text: 'Transferir dinero',
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TransferMoneyPage()),
            );
            if (result == true) {
              onTransferComplete
                  ?.call(); // Llamamos al callback si la transferencia fue exitosa
            }
          },
        ),
        _buildCard(icon: Icons.payments_outlined, text: 'Recibir dinero'),
        _buildCard(
            icon: Icons.qr_code_scanner_outlined, text: 'Escanear o mostar QR'),
        _buildCard(icon: Icons.lightbulb_outline, text: 'Pagar servicios'),
        _buildCard(icon: Icons.credit_score_outlined, text: 'Pagar tarjetas'),
        _buildCard(
            icon: Icons.mobile_friendly_outlined, text: 'Retirar sin tarjeta'),
        _buildCard(icon: Icons.phone, text: 'Recargar celular'),
        _buildCard(
            icon: Icons.wallet_giftcard_outlined, text: 'Transferir un regalo'),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shadowColor: const Color.fromARGB(255, 116, 116, 116),
        shape: const RoundedRectangleBorder(
          side:
              BorderSide(color: Color.fromARGB(255, 157, 157, 157), width: 0.1),
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
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
