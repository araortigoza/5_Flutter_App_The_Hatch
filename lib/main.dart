import 'package:flutter/material.dart'; // SE IMPORTA LA LIBRERIA PARA PINTAR ELEMENTOS EN PANTALLA (BOTONES, TEXTOS, COLORES, ETC.)

import 'screens/bienvenida_screen.dart'; // SE IMPORTA LA PANTALLA INICIAL DE BIENVENIDA

// FUNCION DEL PUNTO DE ENTRADA, SE EJECUTA AL INICIALIZAR LA APP
void main() {
  runApp(const TareasApp()); // CREA UNA INSTANCIA DE LA CLASE PRINCIPAL
}

// SE CREA UN WIDGET PERSONALIZADO QUE HEREDA DE STATELESSWIDGET
// STATELESSWIDGET ES UN WIDGET CUYO ESTADO INTERNO NO CAMBIA A LO LARGO DEL TIEMPO, NO GUARDA DATOS
class TareasApp extends StatefulWidget {
  // CONSTRUCTOR ESTANDAR DE LOS WIDGETS EN FLUTTER
  const TareasApp({super.key});
  @override
  State<TareasApp> createState() => _TareasAppState();
}

class _TareasAppState extends State<TareasApp> {
  // POLIMORFISMO
  @override
  // DEFINE EL ESTADO INICIAL DE LA PAGINA, SE EJECUTA UNA VEZ CUANDO SE MONTA LA PANTALLA POR PRIMERA VEZ
  void initState() {
    super.initState(); // SE LLAMA AL METODO ORIGINAL DE FLUTTER
    colorApp(); // SE LLAMA A LA FUNCION PARA CARGAR LAS TAREAS
  }

  Color colorApp() {
    int hora = DateTime.now().hour;
    if (hora >= 5 && hora <= 16) {
      return const Color.fromARGB(255, 240, 224, 177);
    } else if (hora >= 17 && hora <= 19) {
      return const Color.fromARGB(255, 234, 178, 166);
    } else {
      return const Color.fromARGB(255, 179, 192, 242);
    }
  }

  // LA KEY SIRVE PARA IDENTIFICAR A ESE WIDGET DENTRO DEL ARBOL DE COMPONENTES
  @override
  // SE DEFINE EL METODO QUE SE EJECUTARA CADA VEZ QUE SE QUIERA MOSTRAR ESTE WIDGET
  // CONTEXT INDICA LA UBICACION EXACTA DEL WIDGET DENTRO DEL ARBOL DE LA APP
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareas', // DEFINE EL TITULO DE LA APP
      theme: ThemeData(
        colorSchemeSeed: colorApp(),
        scaffoldBackgroundColor:
            colorApp(), // SE DEFINE UNA PALETA DE COLORES PARA TODA LA APP
      ),
      home: const BienvenidaScreen(), // SE ESTABLECE COMO PANTALLA INICIAL AL WIDGET DE BIENVENIDA
    );
  }
}
