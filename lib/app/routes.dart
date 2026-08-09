import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../apps/presentacion/presentacion_screen.dart';
import '../apps/contador/contador_screen.dart';
import '../apps/edad/edad_screen.dart';
import '../apps/propinas/propinas_screen.dart';
import '../apps/temperatura/temperatura_screen.dart';
import '../apps/semaforo/semaforo_screen.dart';
import '../apps/estudiante/estudiante_screen.dart';
import '../apps/compras/compras_screen.dart';
import '../apps/productos/productos_screen.dart';
import '../apps/tareas/tareas_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String presentacion = '/presentacion';
  static const String contador = '/contador';
  static const String edad = '/edad';
  static const String propinas = '/propinas';
  static const String temperatura = '/temperatura';
  static const String semaforo = '/semaforo';
  static const String estudiante = '/estudiante';
  static const String compras = '/compras';
  static const String productos = '/productos';
  static const String tareas = '/tareas';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      presentacion: (context) => const PresentacionScreen(),
      contador: (context) => const ContadorScreen(),
      edad: (context) => const EdadScreen(),
      propinas: (context) => const PropinasScreen(),
      temperatura: (context) => const TemperaturaScreen(),
      semaforo: (context) => const SemaforoScreen(),
      estudiante: (context) => const EstudianteScreen(),
      compras: (context) => const ComprasScreen(),
      productos: (context) => const ProductosScreen(),
      tareas: (context) => const TareasScreen(),
    };
  }
}
