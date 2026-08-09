import 'package:flutter/material.dart';

enum TipoConversion { celsiusAFahrenheit, fahrenheitACelsius }

class TemperaturaScreen extends StatefulWidget {
  const TemperaturaScreen({super.key});

  @override
  State<TemperaturaScreen> createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen> {
  final _temperaturaController = TextEditingController();
  TipoConversion _tipoConversion = TipoConversion.celsiusAFahrenheit;
  String _resultado = '';

  @override
  void dispose() {
    _temperaturaController.dispose();
    super.dispose();
  }

  void _convertir() {
    final temperatura = double.tryParse(_temperaturaController.text);

    if (temperatura == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa un número válido'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double resultado;
    String unidadOrigen;
    String unidadDestino;

    if (_tipoConversion == TipoConversion.celsiusAFahrenheit) {
      resultado = (temperatura * 9 / 5) + 32;
      unidadOrigen = '°C';
      unidadDestino = '°F';
    } else {
      resultado = (temperatura - 32) * 5 / 9;
      unidadOrigen = '°F';
      unidadDestino = '°C';
    }

    setState(() {
      _resultado =
          '${temperatura.toStringAsFixed(2)}$unidadOrigen = '
          '${resultado.toStringAsFixed(2)}$unidadDestino';
    });
  }

  void _cambiarTipoConversion(TipoConversion? nuevoTipo) {
    if (nuevoTipo != null) {
      setState(() {
        _tipoConversion = nuevoTipo;
        _resultado = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Temperatura'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.thermostat,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _temperaturaController,
                decoration: InputDecoration(
                  labelText: 'Temperatura',
                  hintText: 'Ingresa la temperatura',
                  prefixIcon: const Icon(Icons.device_thermostat),
                  suffixText:
                      _tipoConversion == TipoConversion.celsiusAFahrenheit
                      ? '°C'
                      : '°F',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                onChanged: (_) {
                  if (_resultado.isNotEmpty) {
                    setState(() {
                      _resultado = '';
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              Text(
                'Tipo de conversión',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    RadioListTile<TipoConversion>(
                      title: const Text('Celsius → Fahrenheit'),
                      subtitle: const Text('°C a °F'),
                      value: TipoConversion.celsiusAFahrenheit,
                      groupValue: _tipoConversion,
                      onChanged: _cambiarTipoConversion,
                    ),
                    RadioListTile<TipoConversion>(
                      title: const Text('Fahrenheit → Celsius'),
                      subtitle: const Text('°F a °C'),
                      value: TipoConversion.fahrenheitACelsius,
                      groupValue: _tipoConversion,
                      onChanged: _cambiarTipoConversion,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _convertir,
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Convertir'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              if (_resultado.isNotEmpty) ...[
                const SizedBox(height: 32),
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Resultado',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _resultado,
                          style: Theme.of(context).textTheme.headlineSmall
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
    );
  }
}
