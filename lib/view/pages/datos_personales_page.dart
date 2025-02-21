import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';

class DatosPersonalesPage extends StatelessWidget {
  const DatosPersonalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.account_balance,
              color: Colors.yellow.shade600,
              size: 40,
            ),
            const SizedBox(width: 16),
            Text(
              'BANCO\nPICHINCHA',
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos Personales',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildInfoItem(
            icon: Icons.person_outline,
            label: 'Nombre de usuario',
            value: user?.username ?? 'No disponible',
          ),
          _buildDivider(),
          _buildInfoItem(
            icon: Icons.email_outlined,
            label: 'Correo electrónico',
            value: user?.email ?? 'No disponible',
          ),
          _buildDivider(),
          _buildInfoItem(
            icon: Icons.credit_card,
            label: 'Número de tarjetas',
            value: user?.cards?.length.toString() ?? '0',
          ),
          if (user?.id != null) ...[
            _buildDivider(),
            _buildInfoItem(
              icon: Icons.numbers,
              label: 'ID de usuario',
              value: user?.id.toString() ?? 'No disponible',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF1A237E),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.grey[200],
    );
  }
}
