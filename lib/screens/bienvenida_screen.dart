import 'package:flutter/material.dart'; // SE IMPORTA PARA ACCEDER A COMPONENTES VISUALES

import 'lista_tareas_screen.dart'; // SE IMPORTA VISTA PARA REDIRIGIR
import 'frases_screen.dart'; // SE IMPORTA VISTA VISTA PARA REDIRIGIR

// SE CREA UN WIDGET PERSONALIZADO QUE HEREDA DE STATELESSWIDGET
// STATELESSWIDGET ES UN WIDGET CUYO ESTADO INTERNO NO CAMBIA A LO LARGO DEL TIEMPO, NO GUARDA DATOS
class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key}); // LA KEY SIRVE PARA IDENTIFICAR A ESE WIDGET DENTRO DEL ARBOL DE COMPONENTES

  // INDICA QUE ESTAREMOS SOBREESCRIBIENDO EL METODO BUIL QUE SE HEREDO
  @override
  // SE DEFINE EL METODO QUE SE EJECUTARA CADA VEZ QUE SE QUIERA MOSTRAR ESTE WIDGET
  // CONTEXT INDICA LA UBICACION EXACTA DEL WIDGET DENTRO DEL ARBOL DE LA APP
  Widget build(BuildContext context) {
    // SCAFFOLD PROVEE LA ESTRUCTURA VISUAL DE LA PANTALLA
    return Scaffold(
      // SE CREA UNA BARRA SUPERIOR EN PANTALLA CON LA BIENVENIDA
      appBar: AppBar(title: const Text('Bienvenida')),
      // SE DEFINE EL CONTENIDO CENTRAL DE LA PANTALLA Y LO UBICA EN EL CENTRO
      body: Center(
        // ANHADE UN MARGEN DE RELLENO ALREDEDOR DEL CONTENIDO
        child: Padding(
          padding: const EdgeInsets.all(24),
          // SE DEFINE COMO COLUMNA PARA ORDENAR ELEMENTOS DE ARRIBA HACIA ABAJO
          child: Column(
            // CENTRO LOS ELEMENTOS DENTRO DE LA COLUMNA
            mainAxisAlignment: MainAxisAlignment.center,
            // UNA LISTA DE HIJOS QUE FORMARAN LA COLUMNA
            children: [
              const Text('¡Hola!', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 16), // CAJA VACIA PARA SEPARAR TEXTOS
              const Text(
                'Qué alegría verte por aquí. Juntos vamos a conquistar el día.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              // SE DECLARA UN BOTON QUE RECIBE COMO PARAMETROS ONPRESSED Y CHILD
              ElevatedButton(
                onPressed: () {
                  // TOMA UNA NUEVA PANTALLA Y LA COLOCA ENCIMA DE LA ANTERIOR
                  Navigator.push(
                    context,
                    // LA NUEVA PANTALLA
                    MaterialPageRoute(
                      // SE DECLARA QUE LA NUEVA PANTALLA SERA EL WIDGET DE LISTA DE TAREAS
                      builder: (context) => const ListaTareasScreen(),
                    ),
                  );
                },
                // TEXTO QUE VA DENTRO DEL BOTON
                child: const Text('Mi lista de tareas'),
              ),
              const SizedBox(height: 12),
              // SE DECLARA UN BOTON QUE RECIBE COMO PARAMETROS ONPRESSED Y CHILD
              ElevatedButton(
                onPressed: () {
                  // TOMA UNA NUEVA PANTALLA Y LA COLOCA ENCIMA DE LA ANTERIOR
                  Navigator.push(
                    context,
                    // LA NUEVA PANTALLA
                    MaterialPageRoute(
                      // SE DECLARA QUE LA NUEVA PANTALLA SERA EL WIDGET DE LAS FRASES
                      builder: (context) => const FrasesScreen(),
                    ),
                  );
                },
                // TEXTO QUE VA DENTRO DEL BOTON
                child: const Text('Inspiración diaria'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
