import 'package:flutter/material.dart';
import 'package:interfaz_banco/view/widgets/productos_inicio/tarjeta_cuenta.dart';
import 'package:interfaz_banco/view/widgets/productos_inicio/tipos_opciones.dart';
import 'package:interfaz_banco/view/widgets/productos_inicio/tipos_productos.dart';
import 'package:provider/provider.dart';
import '../../../controller/card_controller.dart';
import '../../../model/card_model.dart' as card_model;
import '../../../provider/user_provider.dart';

class ProductosWidget extends StatefulWidget {
  // Cambiamos a StatefulWidget
  const ProductosWidget({super.key});

  @override
  State<ProductosWidget> createState() => _ProductosWidgetState();
}

class _ProductosWidgetState extends State<ProductosWidget> {
  Key _futureBuilderKey = UniqueKey(); // Clave para forzar reconstrucción

  void _refreshCards() {
    setState(() {
      _futureBuilderKey = UniqueKey();
    });
  }

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
          StreamBuilder<void>(
            stream: context.watch<UserProvider>().stream,
            builder: (context, _) {
              final userProvider = context.read<UserProvider>();

              if (userProvider.currentUser == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return FutureBuilder<List<card_model.Card>>(
                key: _futureBuilderKey, // Agregamos la key aquí
                future: CardController.getUserCards(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Error al cargar las tarjetas: ${snapshot.error}',
                          style: TextStyle(color: Colors.red.shade800),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.credit_card_off,
                              size: 48,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No tienes tarjetas registradas',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final cards = snapshot.data!;
                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: cards
                              .map((card) => Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: SizedBox(
                                      width: 300,
                                      child: TarjetaCuenta(card: card),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text("1 de ${cards.length} >"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Text('¿Qué quieres hacer?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TiposOpciones(onTransferComplete: _refreshCards), // Pasamos callback
        ],
      ),
    );
  }
}
