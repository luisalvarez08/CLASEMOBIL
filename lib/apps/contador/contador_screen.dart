import 'package:flutter/material.dart';

class ContadorScreen extends StatefulWidget {
  const ContadorScreen({super.key});

  @override
  State<ContadorScreen> createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  int _contador = 0;
  static const int _capacidadMaxima = 20;

  void _incrementar() {
    if (_contador < _capacidadMaxima) {
      setState(() {
        _contador++;
      });
    }
  }

  void _decrementar() {
    if (_contador > 0) {
      setState(() {
        _contador--;
      });
    }
  }

  void _reiniciar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Deseas reiniciar el contador a 0?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _contador = 0;
              });
              Navigator.pop(context);
            },
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool capacidadAlcanzada = _contador >= _capacidadMaxima;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador de Personas'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  size: 80,
                  color: capacidadAlcanzada
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  '$_contador',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: capacidadAlcanzada
                        ? Colors.red
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _contador == 1 ? 'persona' : 'personas',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                if (capacidadAlcanzada)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          'Capacidad alcanzada',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: _contador > 0 ? _decrementar : null,
                      backgroundColor: _contador > 0
                          ? Theme.of(context).colorScheme.error
                          : Colors.grey,
                      icon: const Icon(Icons.remove),
                      label: const Text('Restar'),
                      heroTag: 'decrementar',
                    ),
                    const SizedBox(width: 16),
                    FloatingActionButton.extended(
                      onPressed: !capacidadAlcanzada ? _incrementar : null,
                      backgroundColor: !capacidadAlcanzada
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar'),
                      heroTag: 'incrementar',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: _contador > 0 ? _reiniciar : null,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
