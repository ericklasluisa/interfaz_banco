import 'package:flutter/material.dart';

class TiposProductos extends StatelessWidget {
  final String nombre;
  final bool isSelected;
  final Function(String) onSelected;

  const TiposProductos({
    super.key,
    required this.nombre,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onSelected(nombre),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Colors.indigo.shade900 : Colors.grey.shade300,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      child: Text(
        nombre,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TiposProductosList extends StatefulWidget {
  const TiposProductosList({super.key});

  @override
  TiposProductosListState createState() => TiposProductosListState();
}

class TiposProductosListState extends State<TiposProductosList> {
  String _selectedProduct = "Todos";

  void _onProductSelected(String nombre) {
    setState(() {
      _selectedProduct = nombre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TiposProductos(
            nombre: "Todos",
            isSelected: _selectedProduct == "Todos",
            onSelected: _onProductSelected,
          ),
          const SizedBox(width: 10),
          TiposProductos(
            nombre: "Cuentas",
            isSelected: _selectedProduct == "Cuentas",
            onSelected: _onProductSelected,
          ),
          const SizedBox(width: 10),
          TiposProductos(
            nombre: "Tarjetas",
            isSelected: _selectedProduct == "Tarjetas",
            onSelected: _onProductSelected,
          ),
          const SizedBox(width: 10),
          TiposProductos(
            nombre: "Préstamos",
            isSelected: _selectedProduct == "Préstamos",
            onSelected: _onProductSelected,
          ),
          const SizedBox(width: 10),
          TiposProductos(
            nombre: "Inversiones",
            isSelected: _selectedProduct == "Inversiones",
            onSelected: _onProductSelected,
          ),
        ],
      ),
    );
  }
}
