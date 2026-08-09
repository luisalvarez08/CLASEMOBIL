import 'package:flutter/material.dart';
import 'models/producto.dart';
import 'producto_detalle_screen.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  static final List<Producto> _productos = [
    Producto(
      nombre: 'Computadora Portátil',
      precio: 45000.00,
      descripcion:
          'Laptop de alto rendimiento con procesador Intel Core i7, '
          '16GB RAM, 512GB SSD. Ideal para trabajo y entretenimiento.',
      categoria: 'Electrónica',
    ),
    Producto(
      nombre: 'Teléfono Móvil',
      precio: 25000.00,
      descripcion:
          'Smartphone de última generación con cámara de 48MP, '
          'pantalla AMOLED de 6.5", 128GB almacenamiento.',
      categoria: 'Electrónica',
    ),
    Producto(
      nombre: 'Audífonos Bluetooth',
      precio: 3500.00,
      descripcion:
          'Audífonos inalámbricos con cancelación de ruido, '
          'batería de larga duración y sonido de alta calidad.',
      categoria: 'Audio',
    ),
    Producto(
      nombre: 'Teclado Mecánico',
      precio: 4200.00,
      descripcion:
          'Teclado gaming mecánico RGB con switches azules, '
          'diseño ergonómico y teclas programables.',
      categoria: 'Accesorios',
    ),
    Producto(
      nombre: 'Reloj Inteligente',
      precio: 8500.00,
      descripcion:
          'Smartwatch con monitor de frecuencia cardíaca, GPS, '
          'resistente al agua y múltiples modos deportivos.',
      categoria: 'Wearables',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Productos'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: _productos.length,
          itemBuilder: (context, index) {
            final producto = _productos[index];
            return _ProductoCard(
              producto: producto,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductoDetalleScreen(producto: producto),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTap;

  const _ProductoCard({required this.producto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.store,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producto.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        producto.categoria,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'RD\$ ${producto.precio.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
