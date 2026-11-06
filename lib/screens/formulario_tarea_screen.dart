import 'package:flutter/material.dart';

import '../models/tarea.dart';

class FormularioTareaScreen extends StatefulWidget {
  final Tarea? tarea;

  const FormularioTareaScreen({super.key, this.tarea});

  @override
  State<FormularioTareaScreen> createState() => _FormularioTareaScreenState();
}

class _FormularioTareaScreenState extends State<FormularioTareaScreen> {
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();
  DateTime fecha = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.tarea != null) {
      tituloController.text = widget.tarea!.titulo;
      descripcionController.text = widget.tarea!.descripcion;
      fecha = widget.tarea!.fecha;
    }
  }

  Future<void> elegirFecha() async {
    final elegida = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (elegida != null) {
      setState(() {
        fecha = elegida;
      });
    }
  }

  void guardar() {
    if (tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un título para la tarea')),
      );
      return;
    }
    Navigator.pop(
      context,
      Tarea(
        titulo: tituloController.text.trim(),
        descripcion: descripcionController.text.trim(),
        fecha: fecha,
        completada: widget.tarea?.completada ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarea == null ? 'Nueva tarea' : 'Editar tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción (opcional)',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Fecha: ${fecha.day}/${fecha.month}/${fecha.year}',
                  ),
                ),
                TextButton(
                  onPressed: elegirFecha,
                  child: const Text('Cambiar fecha'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: guardar, child: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}
