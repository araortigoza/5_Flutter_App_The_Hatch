import 'package:flutter/material.dart'; // SE IMPORTA PARA ACCEDER A COMPONENTES VISUALES

import '../models/tarea.dart'; // SE IMPORTA EL MODEL DE TAREAS
import 'formulario_tarea_screen.dart'; // SE IMPORTA LA PANTALLA DE FORMULARIO PARA EDITAR

// SE CREA UN WIDGET PERSONALIZADO QUE HEREDA DE STATELESSWIDGET
// STATELESSWIDGET ES UN WIDGET CUYO ESTADO INTERNO NO CAMBIA A LO LARGO DEL TIEMPO, NO GUARDA DATOS
class DetalleTareaScreen extends StatelessWidget {
  final Tarea tarea; // ASIGNA LA TAREA RECIBIDA
  // Tarea({
  //          titulo: "Estudiar flutter",
  //          descripcion: '',
  //          fecha: 13/11/2026 ,
  //          completada = true
  //      })

  const DetalleTareaScreen({super.key, required this.tarea}); // KEY PARA IDENTIFICAR AL WIDGET EN EL ARBOL Y LA TAREA ESPECIFICA MOSTRAR

  // METODO PARA PERMITIR EDITAR TAREA
  Future<void> editar(BuildContext context) async {
    // DIBUJA SOBRE LA PANTALLA EL FORMULARIO QUE PERMITE EDITAR LA TAREA
    final editada = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioTareaScreen(tarea: tarea),
      ),
    );
    // VERIFICA SI SE GUARDO CAMBIOS A UNA TAREA Y SI LA PANTALLA ACTUAL SIGUE ACTIVA
    if (editada != null && context.mounted) {
      // CIERRA LA PANTALLA DE DETALLES Y ENVIA LO QUE FUE EDITADO A LA PANTALLA PRINCIPAL
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
