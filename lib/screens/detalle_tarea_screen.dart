import 'package:flutter/material.dart';

import '../models/tarea.dart';
import 'formulario_tarea_screen.dart';

class DetalleTareaScreen extends StatelessWidget {
  final Tarea tarea;

  const DetalleTareaScreen({super.key, required this.tarea});

  Future<void> editar(BuildContext context) async {
    final editada = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioTareaScreen(tarea: tarea),
      ),
    );
    if (editada != null && context.mounted) {
      Navigator.pop(context, editada);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de la tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tarea.titulo,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              tarea.descripcion.isEmpty ? 'Sin descripción' : tarea.descripcion,
            ),
            const SizedBox(height: 16),
            Text(
              'Fecha: ${tarea.fecha.day}/${tarea.fecha.month}/${tarea.fecha.year}',
            ),
            const SizedBox(height: 8),
            Text('Estado: ${tarea.completada ? 'Completada' : 'Pendiente'}'),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => editar(context),
                  child: const Text('Editar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'eliminar'),
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
