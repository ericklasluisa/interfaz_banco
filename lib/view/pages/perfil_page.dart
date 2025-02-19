import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                _buildSection('Información personal', [
                  _buildListItem(
                    icon: Icons.person_outline,
                    title: 'Datos personales',
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSection(
                  'Configuración',
                  [
                    _buildListItem(
                      icon: Icons.account_balance_outlined,
                      title: 'Cuentas',
                    ),
                  ],
                  showNewBadge: true,
                ),
                const SizedBox(height: 24),
                _buildSection('Experiencia en el app', [
                  _buildListItem(
                    icon: Icons.mobile_friendly_outlined,
                    title: 'Nuevas funcionalidades',
                  ),
                  _buildListItem(
                    icon: Icons.star_border,
                    title: 'Califícanos',
                    showDivider: true,
                  ),
                  _buildListItem(
                    icon: Icons.sentiment_satisfied_alt_outlined,
                    title: 'Envíanos tu opinión',
                    showDivider: false,
                  ),
                  _buildListItem(
                    icon: Icons.library_add_check_outlined,
                    title: 'Términos y condiciones',
                    showDivider: false,
                  ),
                  _buildListItem(
                    icon: Icons.local_phone_outlined,
                    title: 'Contáctanos',
                    showDivider: false,
                  ),
                ]),
                const SizedBox(height: 28),
                _cerrarSesion(context),
                const SizedBox(height: 30),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.grey.shade100,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.indigo.shade100,
            child: const Text(
              'E',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Erick',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Última conexión: 22 ene. 2025 | 15:51',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items,
      {bool showNewBadge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (showNewBadge) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'NUEVO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: const Color(0xFF1A237E),
            size: 24,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.grey[200],
          ),
      ],
    );
  }

  Widget _cerrarSesion(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await FirebaseAuth.instance.signOut();
          // Navegar al login y eliminar todas las rutas anteriores
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login', // Asegúrate de tener esta ruta definida en tu MaterialApp
            (route) => false,
          );
        } catch (e) {
          debugPrint('Error al cerrar sesión: $e');
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.logout_outlined,
            color: Colors.blue.shade800,
          ),
          const SizedBox(width: 8),
          Text(
            'Cerrar sesión',
            style: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
