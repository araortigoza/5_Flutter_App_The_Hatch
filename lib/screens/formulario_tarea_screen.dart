import 'package:flutter/material.dart'; // SE IMPORTA PARA ACCEDER A COMPONENTES VISUALES

import '../models/tarea.dart'; // SE IMPORTA EL MODELO DEFINIDO DE TAREA

// FORMULARIO QUE SE ENCARGA DE CREAR Y EDITAR
// SE CREA EL WIDGET PARA LA LISTA DE TAREAS HEREDANDO STATEFUL (ESTADO)
class FormularioTareaScreen extends StatefulWidget {
  final Tarea? tarea; // VARIABLE TAREA - PODRIA SER NULO

  const FormularioTareaScreen({super.key, this.tarea}); // KEY PARA IDENTIFICAR AL WIDGET EN EL ARBOL Y LA TAREA ESPECIFICA A EDITAR

  // ANOTACION PARA INDICAR QUE SE SOBREESCRIBE UN METODO DE LA CLASE PADRE
  @override
  // INDICA QUE LA FUNCION DEVOLVERA UN DATO TIPO STATE (ADMIN DE ESTADO) Y QUE ESTA LIGADO A NUESTRA PANTALLA
  // FLUTTER BUSCA Y EJECUTA ESTA FUNCION APENAS MUESTRA LA PANTALLA PARA SABER QUIEN GESTIONARA EL ESTADO DE LA PANTALLA
  State<FormularioTareaScreen> createState() => _FormularioTareaScreenState(); // CREA Y DEVUELVE UNA INSTANCIA DE LA CLASE PRIVADA
}

// SE CREA LA CLAVE PIVADA, SE HEREDA STATE E INDICA QUE ESTO ESTA LIGADO A ESTA PANTALLA
class _FormularioTareaScreenState extends State<FormularioTareaScreen> {
  // OBJETOS ENCARGADOR DE LEER Y ESCRIBIR TEXTO EN LAS CAJAS DE TEXTO
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();
  DateTime fecha = DateTime.now(); // PERMITE ACCEDES A FECHA

  // ANOTACION PARA INDICAR QUE SE SOBREESCRIBE UN METODO DE LA CLASE PADRE
  @override
  // DEFINE EL ESTADO INICIAL DE LA PAGINA, SE EJECUTA UNA VEZ CUANDO SE MONTA LA PANTALLA POR PRIMERA VEZ
  void initState() {
    super.initState(); // SE LLAMA AL METODO ORIGINAL DE FLUTTER
    // WIDGET.TAREA PERMITE ACCEDER A PROPS QUE LLEGARON EN LA CLASE PRINCIPAL
    // SI LA TAREA NO ES NULL (SE ESTA EDITANDO)
    if (widget.tarea != null) {
      tituloController.text = widget
          .tarea!
          .titulo; // LE ASIGNA A LA CAJA DE TEXTO EL NOMBRE DE LA TAREA
      descripcionController.text = widget.tarea!.descripcion; // LE ASIGNA A LA CAJA DE TEXTO LA DESCRIPCION DE LA TAREA
      fecha = widget
          .tarea!
          .fecha; // LE ASIGNA A LA CAJA DE TEXTO LA FECHA DE LA TAREA
    }
  }

  // METODO PARA CARGAR ELEGIR UNA FECHA A LA TAREA
  //FUTURE INDICA UN METODO PROMESA Y ASYNC ASINCRONICA
  Future<void> elegirFecha() async {
    // FUNCION DE FLUTTER QUE ABRE EL CALENDARIO VISUAL NATIVO DEL DISPOSITIVO
    final elegida = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(2000), // DESDE QUE ANHO
      lastDate: DateTime(2100), // HASTA QUE ANHO
    );
    // SI LA FECHA NO ES NULL
    if (elegida != null) {
      // CAMBIA EL ESTADO
      setState(() {
        fecha = elegida; // ACTUALIZA LA FECHA POR LA NUEVA
      });
    }
  }

  // METODO PARA GUARDADO Y VALIDACION
  void guardar() {
    // SI ES TITULO ESTA VACIO
    if (tituloController.text.trim().isEmpty) {
      // ABRE UNA ADVERTENCIA VISUAL FLOTANTE CON EL TEXTO DEFINIDO
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un título para la tarea')),
      );
      return;
    }
    // CIERRA LA PANTALLA Y DEVUELVE A LA PANTALLA ANTERIOR
    Navigator.pop(
      context,
      // CREA EL OBJETO TAREA Y LA DEVUELVE A LA PANTALLA ANTERIOR
      Tarea(
        titulo: tituloController.text.trim(),
        descripcion: descripcionController.text.trim(),
        fecha: fecha,
        completada:
            widget.tarea?.completada ??
            false, // ASIGNA EL VALOR DE LA TAREA RECIBIDA ANTES DE SER EDITADA
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
