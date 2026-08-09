import 'dart:async';
import 'package:flutter/material.dart';

enum EstadoSemaforo { rojo, verde, amarillo }

class SemaforoScreen extends StatefulWidget {
  const SemaforoScreen({super.key});

  @override
  State<SemaforoScreen> createState() => _SemaforoScreenState();
}

class _SemaforoScreenState extends State<SemaforoScreen> {
  EstadoSemaforo _estadoActual = EstadoSemaforo.rojo;
  Timer? _timer;
  bool _automatico = true;

  @override
  void initState() {
    super.initState();
    _iniciarCambioAutomatico();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciarCambioAutomatico() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_automatico) {
        _cambiarLuz();
      }
    });
  }

  void _cambiarLuz() {
    setState(() {
      switch (_estadoActual) {
        case EstadoSemaforo.rojo:
          _estadoActual = EstadoSemaforo.verde;
          break;
        case EstadoSemaforo.verde:
          _estadoActual = EstadoSemaforo.amarillo;
          break;
        case EstadoSemaforo.amarillo:
          _estadoActual = EstadoSemaforo.rojo;
          break;
      }
    });
  }

  void _toggleAutomatico() {
    setState(() {
      _automatico = !_automatico;
      if (_automatico) {
        _iniciarCambioAutomatico();
      }
    });
  }

  String _obtenerMensaje() {
    switch (_estadoActual) {
      case EstadoSemaforo.rojo:
        return 'Deténgase';
      case EstadoSemaforo.amarillo:
        return 'Prepárese';
      case EstadoSemaforo.verde:
        return 'Puede avanzar';
    }
  }

  Color _obtenerColorMensaje() {
    switch (_estadoActual) {
      case EstadoSemaforo.rojo:
        return Colors.red;
      case EstadoSemaforo.amarillo:
        return Colors.orange;
      case EstadoSemaforo.verde:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semáforo Interactivo'),
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
                  Icons.traffic,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _LuzSemaforo(
                        color: Colors.red,
                        activa: _estadoActual == EstadoSemaforo.rojo,
                      ),
                      const SizedBox(height: 16),
                      _LuzSemaforo(
                        color: Colors.yellow,
                        activa: _estadoActual == EstadoSemaforo.amarillo,
                      ),
                      const SizedBox(height: 16),
                      _LuzSemaforo(
                        color: Colors.green,
                        activa: _estadoActual == EstadoSemaforo.verde,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: _obtenerColorMensaje().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _obtenerColorMensaje(), width: 2),
                  ),
                  child: Text(
                    _obtenerMensaje(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _obtenerColorMensaje(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: _cambiarLuz,
                      icon: const Icon(Icons.sync),
                      label: const Text('Cambiar'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: _toggleAutomatico,
                      icon: Icon(_automatico ? Icons.pause : Icons.play_arrow),
                      label: Text(_automatico ? 'Pausar' : 'Reanudar'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _automatico ? 'Modo automático (cada 10s)' : 'Modo manual',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
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

class _LuzSemaforo extends StatelessWidget {
  final Color color;
  final bool activa;

  const _LuzSemaforo({required this.color, required this.activa});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: activa ? color : Colors.grey[800],
        boxShadow: activa
            ? [
                BoxShadow(
                  color: color.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ]
            : null,
      ),
    );
  }
}
