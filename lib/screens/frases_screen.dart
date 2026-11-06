import 'dart:math'; // SE IMPORTA LA LIBRERIA PARA USAR RANDOM

import 'package:flutter/material.dart'; // SE IMPORTA PARA ACCEDER A COMPONENTES VISUALES

// SE CREA UN WIDGET PERSONALIZADO QUE HEREDA DE STATEFULWIDGET
// STATEFULWIDGET ES UN WIDGET CON ESTADO, ES DECIR, EL ESTADO SI PUEDE CAMBIAR
class FrasesScreen extends StatefulWidget {
  const FrasesScreen({super.key});

  @override
  State<FrasesScreen> createState() => _FrasesScreenState();
}

class _FrasesScreenState extends State<FrasesScreen> {
  final List<String> frases = [
    'Hoy es un buen día para empezar.',
    'Un pequeño paso hoy vale más que un gran plan mañana.',
    'No tienes que hacerlo perfecto, solo tienes que empezar.',
    'Cada tarea terminada es una victoria.',
    'Tú puedes más de lo que crees.',
    'La constancia le gana al talento cuando el talento no es constante.',
    'Lo que hagas hoy te lo va a agradecer tu yo de mañana.',
    'Si crees que puedes, ya estás a medio camino',
    'Los grandes logros empiezan con una pequeña tarea.',
    'Hoy vas a sorprenderte de lo que eres capaz.',
  ];

  late String frase;

  @override
  void initState() {
    super.initState();
    frase = nuevaFrase();
  }

  String nuevaFrase() {
    return frases[Random().nextInt(frases.length)];
  }

  void refrescar() {
    setState(() {
      frase = nuevaFrase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inspiración diaria')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                frase,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: refrescar,
                child: const Text('Otra frase'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
