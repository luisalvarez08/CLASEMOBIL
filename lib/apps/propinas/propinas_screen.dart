import 'package:flutter/material.dart';

class PropinasScreen extends StatefulWidget {
  const PropinasScreen({super.key});

  @override
  State<PropinasScreen> createState() => _PropinasScreenState();
}

class _PropinasScreenState extends State<PropinasScreen> {
  final _montoController = TextEditingController();
  int _porcentajeSeleccionado = 10;
  double _propina = 0;
  double _total = 0;
  bool _calculado = false;

  @override
  void dispose() {
    _montoController.dispose();
    super.dispose();
  }

  void _calcular() {
    final monto = double.tryParse(_montoController.text);

    if (monto == null || monto <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa un monto válido mayor que cero'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _propina = monto * _porcentajeSeleccionado / 100;
      _total = monto + _propina;
      _calculado = true;
    });
  }

  void _reiniciar() {
    setState(() {
      _montoController.clear();
      _porcentajeSeleccionado = 10;
      _propina = 0;
      _total = 0;
      _calculado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Propinas'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.attach_money,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _montoController,
                decoration: const InputDecoration(
                  labelText: 'Monto de la cuenta',
                  hintText: 'Ej: 1000',
                  prefixText: 'RD\$ ',
                  prefixIcon: Icon(Icons.receipt_long),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) {
                  if (_calculado) {
                    setState(() {
                      _calculado = false;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              Text(
                'Porcentaje de propina',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    RadioListTile<int>(
                      title: const Text('5%'),
                      value: 5,
                      groupValue: _porcentajeSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _porcentajeSeleccionado = value!;
                          if (_calculado) _calcular();
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('10%'),
                      value: 10,
                      groupValue: _porcentajeSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _porcentajeSeleccionado = value!;
                          if (_calculado) _calcular();
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('15%'),
                      value: 15,
                      groupValue: _porcentajeSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _porcentajeSeleccionado = value!;
                          if (_calculado) _calcular();
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('20%'),
                      value: 20,
                      groupValue: _porcentajeSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _porcentajeSeleccionado = value!;
                          if (_calculado) _calcular();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _calcular,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calcular'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _reiniciar,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reiniciar'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
              if (_calculado) ...[
                const SizedBox(height: 32),
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _ResultadoItem(
                          label: 'Propina ($_porcentajeSeleccionado%)',
                          valor: _propina,
                        ),
                        const Divider(height: 24),
                        _ResultadoItem(
                          label: 'Total a pagar',
                          valor: _total,
                          esTotal: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultadoItem extends StatelessWidget {
  final String label;
  final double valor;
  final bool esTotal;

  const _ResultadoItem({
    required this.label,
    required this.valor,
    this.esTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: esTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          'RD\$ ${valor.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: esTotal ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
