import 'package:flutter/material.dart'; // SE IMPORTA PARA ACCEDER A COMPONENTES VISUALES

import '../models/tarea.dart'; // SE IMPORTA EL MODELO DEFINIDO DE TAREA
import '../services/almacenamiento.dart'; // SE IMPORTA FUNCIONES DE CARGAR Y GUARDAR
import 'detalle_tarea_screen.dart'; // IMPORTA LA PANTALLA PARA VER DETALLER
import 'formulario_tarea_screen.dart'; // IMPORTA LA PANTALLA PARA CREAR NUEVA TAREA

// SE CREA EL WIDGET PARA LA LISTA DE TAREAS HERENADO STATEFUL (ESTADO)
class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key}); // SE TOMA LA KEY PARA IDENTIFICARLO

  // POLIMORFISMO
  @override
  // INDICA QUE LA FUNCION DEVOLVERA UN DATO TIPO STATE (ADMIN DE ESTADO) Y QUE ESTA LIGADO A NUESTRA PANTALLA
  // FLUTTER BUSCA Y EJECUTA ESTA FUNCION APENAS MUESTRA LA PANTALLA PARA SABER QUIEN GESTIONARA EL ESTADO DE LA PANTALLA
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

// CLASE PRIVADA QUE CONTENDRA EL ESTADO DE LA PANTALLA
class _ListaTareasScreenState extends State<ListaTareasScreen> {
  List<Tarea> tareas = []; // SE DEFINE UNA LISTA DE LOS OBJETOS TAREA

  // POLIMORFISMO
  @override
  // DEFINE EL ESTADO INICIAL DE LA PAGINA, SE EJECUTA UNA VEZ CUANDO SE MONTA LA PANTALLA POR PRIMERA VEZ
  void initState() {
    super.initState(); // SE LLAMA AL METODO ORIGINAL DE FLUTTER
    cargar(); // SE LLAMA A LA FUNCION PARA CARGAR LAS TAREAS
  }

  // METODO PARA CARGAR LAS TAREAS
  //FUTURE INDICA UN METODO PROMESA Y ASYNC ASINCRONICA
  Future<void> cargar() async {
    final guardadas = await cargarTareas(); // REALIZA LA CONSULTA EN MEMORIA
    // CAMBIA EL ESTADO
    setState(() {
      tareas = guardadas; // ASIGNA A LA VARIABLE TAREAS LAS TAREAS ENCONTRADAS
    });
  }

  // METODO PARA AGREGAR NUEVAS TAREAS
  Future<void> agregar() async {
    // DIBUJA LA PANTALLA DE FORMULARIO Y ESPERA A QUE SE LE DEVUELVA UN OBJETO TIPO TAREA
    final nueva = await Navigator.push<Tarea>(
      context, // IDENTIFICA LA UBICACION PARA SABER DONDE DIBUJAR LA PANTALLA
      // DEFINE LA TRANSICION VISUAL DE LA PANTALLA
      MaterialPageRoute(builder: (context) => const FormularioTareaScreen()),
    );
    // COMPRUEBA SI REALMENTE SE CREO UNA TAREA
    if (nueva != null) {
      // CAMBIA EL ESTADO
      setState(() {
        tareas.add(nueva); // ANHADE LA NUEVA TAREA
      });
      guardarTareas(
        tareas,
      ); // LLAMA A LA FUNCION PARA GUARDAR LA TAREA EN MEMORIA
    }
  }

  // METODO PARA ABRIR EL DETALLE DE LAS TAREAS
  // RECIBE EL INDICE O POSICION DE LA TAREA ESPECIFICA DENTRO DE LA LISTA
  Future<void> abrirDetalle(int index) async {
    // DIBUJA LA PANTALLA DE FORMULARIO Y ESPERA A QUE SE LE DEVUELVA UN TIPO OBJETO
    final resultado = await Navigator.push<Object>(
      context, // IDENTIFICA LA UBICACION PARA SABER DONDE DIBUJAR LA PANTALLA
      // DEFINE LA TRANSICION VISUAL DE LA PANTALLA
      MaterialPageRoute(
        builder: (context) => DetalleTareaScreen(tarea: tareas[index]),
      ),
    );
    // AL VOLVER
    // VERIFICA SI EL USUARIO QUISO ELIMINAR ESA TAREA, ENTONCES LO HACE
    if (resultado == 'eliminar') {
      eliminar(index);
      // O SI LA EDITO
    } else if (resultado is Tarea) {
      // CAMBIA EL ESTADO
      setState(() {
        tareas[index] =
            resultado; // IDENTIFICA LA TAREA EDITADA PARA ASIGNAR LOS CAMBIOS
      });
      // LLAMA A LA FUNCION PARA GUARDAR LAS TAREAS EN MEMORIA
      guardarTareas(tareas);
    }
  }

  // METODO PARA ELIMINAR UNA TAREA ESPECIFICA
  void eliminar(int index) {
    // CAMBIA EL ESTADO
    setState(() {
      tareas.removeAt(index); // REMUEVE LA TAREA
    });
    guardarTareas(
      tareas,
    ); // LLAMA A LA FUNCION PARA GUARDAR LAS TAREAS EN MEMORIA
  }

  // METODO PARA CAMBIAR EL ESTADO DE LA TAREA (COMPLETADA O NO)
  void cambiarEstado(int index, bool? valor) {
    // CAMBIA EL ESTADO
    setState(() {
      tareas[index].completada = valor ?? false; // BUSCA LA TAREA Y LE AGREGA EL VALOR RECIBIDO, POR DEFECTO, FALSE
    });
    guardarTareas(
      tareas,
    ); // LLAMA A LA FUNCION PARA GUARDAR LAS TAREAS EN MEMORIA
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
                  onTap: () => abrirDetalle(
                    index,
                  ), // LO QUE PASA SI EL USUARIO TOCA TODX EL RENGLON
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
