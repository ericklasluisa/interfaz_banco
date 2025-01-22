import 'package:flutter/material.dart';

class SolicitudesPage extends StatelessWidget {
  const SolicitudesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionTitle('Hacer trámites sin ir a agencias'),
            _buildHorizontalCardList(
              [
                CardItem(
                  icon: Icons.credit_card,
                  title: 'Tarjetas\nde debito',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.person_outline,
                  title: 'Actualización\nde datos',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.description_outlined,
                  title: 'Estado de\ncuentas',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.article_outlined,
                  title: 'Certificado\nbancario',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.flag_outlined,
                  title: 'Límite de\ntransferencias',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.attach_money,
                  title: 'Avance de\nefectivo',
                  color: const Color(0xFF1A237E),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Contrata un seguro, ahorra o invierte'),
            _buildHorizontalCardList(
              [
                CardItem(
                  icon: Icons.shield_outlined,
                  title: 'Seguro por\nrobos y fraudes',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.savings_outlined,
                  title: 'Cuenta de\nahorro',
                  color: const Color(0xFF1A237E),
                ),
                CardItem(
                  icon: Icons.trending_up,
                  title: 'Inversión',
                  color: const Color(0xFF1A237E),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 140,
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿Qué necesitas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                Text(
                  'hacer hoy?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Icon(
              Icons.person_search_outlined,
              size: 80,
              color: Colors.indigo.shade600,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildHorizontalCardList(List<CardItem> items) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildCard(items[index]),
          );
        },
      ),
    );
  }

  Widget _buildCard(CardItem item) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 32,
            color: item.color,
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem {
  final IconData icon;
  final String title;
  final Color color;

  CardItem({
    required this.icon,
    required this.title,
    required this.color,
  });
}
