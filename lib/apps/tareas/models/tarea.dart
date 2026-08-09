class Tarea {
  String titulo;
  String descripcion;
  DateTime fechaLimite;
  String prioridad;
  bool completada;

  Tarea({
    required this.titulo,
    required this.descripcion,
    required this.fechaLimite,
    required this.prioridad,
    this.completada = false,
  });
}
