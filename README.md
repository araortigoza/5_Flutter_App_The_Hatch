# Tareas App

App móvil hecha con Flutter y Dart para organizar tareas y encontrar motivación cada día. Funciona en Android e iOS desde una única base de código.

## Funcionalidades

- **Pantalla de bienvenida** con un mensaje amistoso y botones hacia la lista de tareas y la inspiración diaria.
- **Lista de tareas** con botón flotante para agregar, check para marcar como completada y papelera para eliminar.
- **Detalle de tarea** con título, descripción, fecha y estado, desde donde se puede editar o eliminar.
- **Formulario de tarea** para crear y editar, con título, descripción opcional y selector de fecha.
- **Inspiración diaria** con frases motivadoras aleatorias y un botón para mostrar otra.
- **Persistencia de datos**: las tareas se guardan en el dispositivo y siguen ahí al cerrar y volver a abrir la app.

## Tecnologías

- Flutter
- Dart
- shared_preferences

## Estructura del proyecto

```
lib/
├── main.dart
├── models/
│   └── tarea.dart
├── services/
│   └── almacenamiento.dart
└── screens/
    ├── bienvenida_screen.dart
    ├── lista_tareas_screen.dart
    ├── detalle_tarea_screen.dart
    ├── formulario_tarea_screen.dart
    └── frases_screen.dart
```

- `models/tarea.dart`: clase `Tarea` con conversión a JSON.
- `services/almacenamiento.dart`: funciones para guardar y cargar las tareas con SharedPreferences.
- `screens/`: una pantalla por archivo. La navegación usa `Navigator`.

## Requisitos

- Flutter SDK instalado
- Android Studio con el Android SDK, para compilar en Android
- Una Mac con Xcode, para compilar en iOS

## Cómo ejecutar

1. Clonar o descargar el proyecto.
2. Instalar las dependencias:
   ```
   flutter pub get
   ```
3. Conectar un celular con la depuración por USB activada, o iniciar un emulador.
4. Ejecutar la app:
   ```
   flutter run
   ```

Para ver los dispositivos disponibles:

```
flutter devices
```

## Cómo funciona el guardado

Cada tarea se convierte a JSON y la lista completa se guarda como texto con SharedPreferences. Al abrir la pantalla de la lista, se lee ese texto y se convierte de nuevo en tareas. Cada vez que se agrega, edita, elimina o marca una tarea, la lista se vuelve a guardar.