import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/widgets/productos_inicio/tarjeta_cuenta.dart';
import 'package:interfaz_banco/view/widgets/productos_inicio/tipos_productos.dart';

class ProductosWidget extends StatelessWidget {
  const ProductosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mis Productos',
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Ver todos  >',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TiposProductosList(),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 300, // Ajusta el ancho según sea necesario
                  child: TarjetaCuenta(),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 300, // Ajusta el ancho según sea necesario
                  child: TarjetaCuenta(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text("1 de 2 >"),
          )
        ],
      ),
    );
  }
}
