import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/widgets/productos_inicio/productos_widget.dart';
import 'package:interfaz_banco/view/widgets/publicidad_widget.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.account_balance,
          color: Colors.yellow.shade600,
          size: 40,
        ),
        title: Text(
          'Banco\nPichincha',
          style: TextStyle(
            color: Colors.indigo.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.help_outline,
                  color: Colors.indigo.shade600,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  'Ayuda',
                  style: TextStyle(color: Colors.indigo.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Contenido desplazable
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  PublicidadWidget(),
                  ProductosWidget(),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255), // Fondo del menú
              border: Border.all(
                color: const Color.fromARGB(255, 219, 219, 219), // Color del borde
                width: 1.5, // Ancho del borde
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.home, color: Colors.indigo),
                      SizedBox(height: 5),
                      Text(
                        'Inicio',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.account_balance_wallet, color: Colors.indigo),
                      SizedBox(height: 5),
                      Text(
                        'Productos',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.settings, color: Colors.indigo),
                      SizedBox(height: 5),
                      Text(
                        'Ajustes',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.person, color: Colors.indigo),
                      SizedBox(height: 5),
                      Text(
                        'Perfil',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
