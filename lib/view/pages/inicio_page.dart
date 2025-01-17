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
                color: Colors.indigo.shade600, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(color: Colors.indigo.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: const Column(
          children: [
            PublicidadWidget(),
            ProductosWidget(),
          ],
        ));
  }
}
