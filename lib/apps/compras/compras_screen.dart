import 'package:flutter/material.dart';

class ProductoCompra {
  String nombre;
  bool comprado;

  ProductoCompra({required this.nombre, this.comprado = false});
}

class ComprasScreen extends StatefulWidget {
  const ComprasScreen({super.key});

  @override
  State<ComprasScreen> createState() => _ComprasScreenState();
}

class _ComprasScreenState extends State<ComprasScreen> {
  final _productoController = TextEditingController();
  final List<ProductoCompra> _productos = [];

  @override
  void dispose() {
    _productoController.dispose();
    super.dispose();
  }

  void _agregarProducto() {
    final nombre = _productoController.text.trim();

    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa el nombre del producto'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _productos.add(ProductoCompra(nombre: nombre));
      _productoController.clear();
    });
  }

  void _eliminarProducto(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('¿Deseas eliminar "${_productos[index].nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _productos.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _eliminarComprados() {
    final comprados = _productos.where((p) => p.comprado).length;

    if (comprados == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay productos comprados para eliminar'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('¿Deseas eliminar los $comprados productos comprados?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _productos.removeWhere((p) => p.comprado);
              });
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  int get _productosPendientes {
    return _productos.where((p) => !p.comprado).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _productoController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre del producto',
                            hintText: 'Ej: Leche',
                            prefixIcon: Icon(Icons.shopping_basket),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (_) => _agregarProducto(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: _agregarProducto,
                        icon: const Icon(Icons.add),
                        label: const Text('Agregar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _EstadisticaItem(
                            icono: Icons.list,
                            label: 'Total',
                            valor: _productos.length,
                          ),
                          _EstadisticaItem(
                            icono: Icons.pending_actions,
                            label: 'Pendientes',
                            valor: _productosPendientes,
                            color: Colors.orange,
                          ),
                          _EstadisticaItem(
                            icono: Icons.check_circle,
                            label: 'Comprados',
                            valor: _productos.length - _productosPendientes,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_productos.any((p) => p.comprado)) ...[
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _eliminarComprados,
                      icon: const Icon(Icons.delete_sweep),
                      label: const Text('Eliminar productos comprados'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: _productos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay productos en la lista',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _productos.length,
                      itemBuilder: (context, index) {
                        final producto = _productos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: producto.comprado,
                              onChanged: (value) {
                                setState(() {
                                  producto.comprado = value ?? false;
                                });
                              },
                            ),
                            title: Text(
                              producto.nombre,
                              style: TextStyle(
                                decoration: producto.comprado
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: producto.comprado ? Colors.grey : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarProducto(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstadisticaItem extends StatelessWidget {
  final IconData icono;
  final String label;
  final int valor;
  final Color? color;

  const _EstadisticaItem({
    required this.icono,
    required this.label,
    required this.valor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icono, color: color),
        const SizedBox(height: 4),
        Text(
          '$valor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
