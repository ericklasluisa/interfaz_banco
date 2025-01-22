import 'package:flutter/material.dart';
import '../widgets/productos_inicio/productos_widget.dart';
import '../widgets/publicidad_widget.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PublicidadWidget(),
                ProductosWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
