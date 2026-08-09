import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/tarea.dart';

class TareaFormScreen extends StatefulWidget {
  final Tarea? tarea;

  const TareaFormScreen({super.key, this.tarea});

  @override
  State<TareaFormScreen> createState() => _TareaFormScreenState();
}

class _TareaFormScreenState extends State<TareaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime? _fechaLimite;
  String _prioridadSeleccionada = 'Media';

  final List<String> _prioridades = ['Baja', 'Media', 'Alta'];

  @override
  void initState() {
    super.initState();
    if (widget.tarea != null) {
      _tituloController.text = widget.tarea!.titulo;
      _descripcionController.text = widget.tarea!.descripcion;
      _fechaLimite = widget.tarea!.fechaLimite;
      _prioridadSeleccionada = widget.tarea!.prioridad;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: _fechaLimite ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('es', 'ES'),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        _fechaLimite = fechaSeleccionada;
      });
    }
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_fechaLimite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una fecha límite'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final tarea = Tarea(
      titulo: _tituloController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      fechaLimite: _fechaLimite!,
      prioridad: _prioridadSeleccionada,
      completada: widget.tarea?.completada ?? false,
    );

    Navigator.pop(context, tarea);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.tarea != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Tarea' : 'Nueva Tarea'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Icon(
                Icons.task_alt,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ej: Completar proyecto',
                  prefixIcon: Icon(Icons.title),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Descripción de la tarea (opcional)',
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _seleccionarFecha,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Fecha límite',
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: _fechaLimite != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _fechaLimite = null;
                              });
                            },
                          )
                        : null,
                  ),
                  child: Text(
                    _fechaLimite != null
                        ? DateFormat('dd/MM/yyyy').format(_fechaLimite!)
                        : 'Selecciona una fecha',
                    style: TextStyle(
                      color: _fechaLimite != null ? null : Colors.grey[600],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _prioridadSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Prioridad',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: _prioridades.map((prioridad) {
                  return DropdownMenuItem(
                    value: prioridad,
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 12,
                          color: _obtenerColorPrioridad(prioridad),
                        ),
                        const SizedBox(width: 8),
                        Text(prioridad),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _prioridadSeleccionada = value!;
                  });
                },
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.save),
                label: Text(esEdicion ? 'Guardar cambios' : 'Crear tarea'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _obtenerColorPrioridad(String prioridad) {
    switch (prioridad) {
      case 'Alta':
        return Colors.red;
      case 'Media':
        return Colors.orange;
      case 'Baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
