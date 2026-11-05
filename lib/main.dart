import 'package:flutter/material.dart';

import 'screens/bienvenida_screen.dart';

void main() {
  runApp(const TareasApp());
}

class TareasApp extends StatelessWidget {
  const TareasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareas',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      home: const BienvenidaScreen(),
    );
  }
}
