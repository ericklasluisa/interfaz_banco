import 'package:flutter/material.dart';

class PublicidadWidget extends StatelessWidget {
  const PublicidadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Haz todo sin ir al banco',
                      style: TextStyle(
                        color: Colors.indigo.shade800,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Descubre lo que puedes hacer desde tu Banca Móvil',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("Descubrir opciones",
                        style: TextStyle(
                          color: Colors.blue.shade800,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
