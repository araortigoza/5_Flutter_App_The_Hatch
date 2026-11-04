import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/tarea.dart';

Future<List<Tarea>> cargarTareas() async {
  final prefs = await SharedPreferences.getInstance();
  final texto = prefs.getString('tareas');
  if (texto == null) return [];
  final lista = jsonDecode(texto) as List;
  return lista.map((e) => Tarea.fromJson(e)).toList();
}

Future<void> guardarTareas(List<Tarea> tareas) async {
  final prefs = await SharedPreferences.getInstance();
  final texto = jsonEncode(tareas.map((t) => t.toJson()).toList());
  await prefs.setString('tareas', texto);
}
