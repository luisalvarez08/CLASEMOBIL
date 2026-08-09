import 'package:flutter/material.dart';

class EdadScreen extends StatefulWidget {
  const EdadScreen({super.key});

  @override
  State<EdadScreen> createState() => _EdadScreenState();
}

class _EdadScreenState extends State<EdadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _anioController = TextEditingController();
  String _resultado = '';

  @override
  void dispose() {
    _nombreController.dispose();
    _anioController.dispose();
    super.dispose();
  }

  void _calcularEdad() {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text.trim();
      final anioNacimiento = int.parse(_anioController.text);
      final anioActual = DateTime.now().year;
      final edad = anioActual - anioNacimiento;

      setState(() {
        _resultado = '$nombre, tienes aproximadamente $edad años.';
      });
    }
  }

  void _limpiar() {
    setState(() {
      _nombreController.clear();
      _anioController.clear();
      _resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Edad'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.cake,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo',
                    hintText: 'Ingresa tu nombre',
                    prefixIcon: Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _anioController,
                  decoration: const InputDecoration(
                    labelText: 'Año de nacimiento',
                    hintText: 'Ej: 2000',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El año de nacimiento es obligatorio';
                    }

                    final anio = int.tryParse(value);
                    if (anio == null) {
                      return 'Debe ser un número válido';
                    }

                    if (anio < 1900) {
                      return 'El año debe ser mayor que 1900';
                    }

                    final anioActual = DateTime.now().year;
                    if (anio > anioActual) {
                      return 'El año no puede ser mayor que $anioActual';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _calcularEdad,
                        icon: const Icon(Icons.calculate),
                        label: const Text('Calcular edad'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _limpiar,
                        icon: const Icon(Icons.clear),
                        label: const Text('Limpiar'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_resultado.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _resultado,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}
