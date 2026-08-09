import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/tarea.dart';
import 'tarea_form_screen.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  final List<Tarea> _tareas = [];

  void _agregarTarea() async {
    final tarea = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(builder: (context) => const TareaFormScreen()),
    );

    if (tarea != null) {
      setState(() {
        _tareas.add(tarea);
      });
    }
  }

  void _editarTarea(int index) async {
    final tareaEditada = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(
        builder: (context) => TareaFormScreen(tarea: _tareas[index]),
      ),
    );

    if (tareaEditada != null) {
      setState(() {
        _tareas[index] = tareaEditada;
      });
    }
  }

  void _eliminarTarea(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('¿Deseas eliminar "${_tareas[index].titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _tareas.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  int get _totalTareas => _tareas.length;
  int get _tareasPendientes => _tareas.where((t) => !t.completada).length;
  int get _tareasCompletadas => _tareas.where((t) => t.completada).length;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas Pendientes'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _EstadisticaItem(
                        icono: Icons.list,
                        label: 'Total',
                        valor: _totalTareas,
                      ),
                      _EstadisticaItem(
                        icono: Icons.pending_actions,
                        label: 'Pendientes',
                        valor: _tareasPendientes,
                        color: Colors.orange,
                      ),
                      _EstadisticaItem(
                        icono: Icons.check_circle,
                        label: 'Completadas',
                        valor: _tareasCompletadas,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _tareas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay tareas',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Presiona + para agregar una tarea',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = _tareas[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Checkbox(
                              value: tarea.completada,
                              onChanged: (value) {
                                setState(() {
                                  tarea.completada = value ?? false;
                                });
                              },
                            ),
                            title: Text(
                              tarea.titulo,
                              style: TextStyle(
                                decoration: tarea.completada
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontWeight: FontWeight.bold,
                                color: tarea.completada ? Colors.grey : null,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tarea.descripcion.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    tarea.descripcion,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: tarea.completada
                                          ? Colors.grey
                                          : null,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(tarea.fechaLimite),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _obtenerColorPrioridad(
                                          tarea.prioridad,
                                        ).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _obtenerColorPrioridad(
                                            tarea.prioridad,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        tarea.prioridad,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: _obtenerColorPrioridad(
                                            tarea.prioridad,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () => _editarTarea(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () => _eliminarTarea(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarTarea,
        child: const Icon(Icons.add),
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
