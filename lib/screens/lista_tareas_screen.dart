import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../services/almacenamiento.dart';
import 'detalle_tarea_screen.dart';
import 'formulario_tarea_screen.dart';

class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  List<Tarea> tareas = [];

  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future<void> cargar() async {
    final guardadas = await cargarTareas();
    setState(() {
      tareas = guardadas;
    });
  }

  Future<void> agregar() async {
    final nueva = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioTareaScreen()),
    );
    if (nueva != null) {
      setState(() {
        tareas.add(nueva);
      });
      guardarTareas(tareas);
    }
  }

  Future<void> abrirDetalle(int index) async {
    final resultado = await Navigator.push<Object>(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleTareaScreen(tarea: tareas[index]),
      ),
    );
    if (resultado == 'eliminar') {
      eliminar(index);
    } else if (resultado is Tarea) {
      setState(() {
        tareas[index] = resultado;
      });
      guardarTareas(tareas);
    }
  }

  void eliminar(int index) {
    setState(() {
      tareas.removeAt(index);
    });
    guardarTareas(tareas);
  }

  void cambiarEstado(int index, bool? valor) {
    setState(() {
      tareas[index].completada = valor ?? false;
    });
    guardarTareas(tareas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de tareas')),
      body: tareas.isEmpty
          ? const Center(child: Text('No tienes tareas todavía'))
          : ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return ListTile(
                  leading: Checkbox(
                    value: tarea.completada,
                    onChanged: (valor) => cambiarEstado(index, valor),
                  ),
                  title: Text(
                    tarea.titulo,
                    style: TextStyle(
                      decoration: tarea.completada
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(
                    '${tarea.fecha.day}/${tarea.fecha.month}/${tarea.fecha.year}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => eliminar(index),
                  ),
                  onTap: () => abrirDetalle(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
