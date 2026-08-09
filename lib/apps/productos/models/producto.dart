class Producto {
  final String nombre;
  final double precio;
  final String descripcion;
  final String categoria;
  final String? imagen;

  Producto({
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.categoria,
    this.imagen,
  });
}
