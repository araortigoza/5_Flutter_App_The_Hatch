import 'dart:math'; // SE IMPORTA LA LIBRERIA PARA USAR RANDOM

import 'package:flutter/material.dart'; // SE IMPORTA PARA ACCEDER A COMPONENTES VISUALES

// SE CREA UN WIDGET PERSONALIZADO QUE HEREDA DE STATEFULWIDGET
// STATEFULWIDGET ES UN WIDGET CON ESTADO, ES DECIR, EL ESTADO SI PUEDE CAMBIAR
class FrasesScreen extends StatefulWidget {
  const FrasesScreen({super.key}); // KEY PARA IDENTIFICAR AL WIDGET EN EL ARBOL

  // ANOTACION PARA INDICAR QUE SE SOBREESCRIBE UN METODO DE LA CLASE PADRE
  @override
  // INDICA QUE LA FUNCION DEVOLVERA UN DATO TIPO STATE (ADMIN DE ESTADO) Y QUE ESTA LIGADO A NUESTRA PANTALLA
  // FLUTTER BUSCA Y EJECUTA ESTA FUNCION APENAS MUESTRA LA PANTALLA PARA SABER QUIEN GESTIONARA EL ESTADO DE LA PANTALLA
  State<FrasesScreen> createState() => _FrasesScreenState(); // CREA Y DEVUELVE UNA INSTANCIA DE LA CLASE PRIVADA
}

// SE CREA LA CLAVE PIVADA, SE HEREDA STATE E INDICA QUE ESTO ESTA LIGADO A ESTA PANTALLA
class _FrasesScreenState extends State<FrasesScreen> {
  // SE ASIGNA UNA LISTA DE STRINGS LLAMADA FRASES
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

  late String frase; // SE CREA LA VARIABLE FRASE SIN VALOR INICIALMENTE

  // ANOTACION PARA INDICAR QUE SE SOBREESCRIBE UN METODO DE LA CLASE PADRE
  @override
  // DEFINE EL ESTADO INICIAL DE LA PAGINA, SE EJECUTA UNA VEZ CUANDO SE MONTA LA PANTALLA POR PRIMERA VEZ
  void initState() {
    super.initState(); // SE LLAMA AL METODO ORIGINAL DE FLUTTER
    frase = nuevaFrase(); // LE ASIGNA UNA FRASE RANDOM A LA VARIABLE LLAMANDO A LA FUNCION
  }

  // METODO PARA ASIGNAR UNA FRASE DE FORMA RANDOM
  String nuevaFrase() {
    // ASIGNA UNA FRASE DE FORMA RANDOM
    return frases[Random().nextInt(
      frases.length,
    )]; // GENERA UN NUMERO ALEATORIO ENTRE 0 Y LENGTH DE LA LISTA
  }

  // METODO PARA REFRESCAR LA FRASE
  void refrescar() {
    // CAMBIA DE ESTADO PARA MOSTRARLO EN PANTALLA
    setState(() {
      frase = nuevaFrase(); // SE ASIGNA OTRA FRASE RANDOM
    });
  }

  // ANOTACION PARA INDICAR QUE SE SOBREESCRIBE UN METODO DE LA CLASE PADRE
  @override
  // SE DEFINE EL METODO QUE SE EJECUTARA CADA VEZ QUE SE QUIERA MOSTRAR ESTE WIDGET
  // CONTEXT INDICA LA UBICACION EXACTA DEL WIDGET DENTRO DEL ARBOL DE LA APP
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
