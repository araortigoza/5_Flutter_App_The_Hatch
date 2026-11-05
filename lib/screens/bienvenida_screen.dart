import 'package:flutter/material.dart';

import 'lista_tareas_screen.dart';
import 'frases_screen.dart';

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenida')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¡Hola!', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 16),
              const Text(
                'Qué alegría verte por aquí. Juntos vamos a conquistar el día.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListaTareasScreen(),
                    ),
                  );
                },
                child: const Text('Mi lista de tareas'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FrasesScreen(),
                    ),
                  );
                },
                child: const Text('Inspiración diaria'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
