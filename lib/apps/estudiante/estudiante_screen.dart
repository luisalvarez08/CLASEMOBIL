import 'package:flutter/material.dart';

class EstudianteScreen extends StatefulWidget {
  const EstudianteScreen({super.key});

  @override
  State<EstudianteScreen> createState() => _EstudianteScreenState();
}

class _EstudianteScreenState extends State<EstudianteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _edadController = TextEditingController();

  String? _carreraSeleccionada;
  String _sexoSeleccionado = '';
  bool _aceptaTerminos = false;

  final List<String> _carreras = [
    'Ingeniería en Desarrollo de Software',
    'Ingeniería de Sistemas',
    'Administración',
    'Contabilidad',
    'Mercadeo',
  ];

  @override
  void dispose() {
    _matriculaController.dispose();
    _nombreController.dispose();
    _correoController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _registrar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_sexoSeleccionado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona el sexo'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registro Exitoso'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _InfoItem(label: 'Matrícula', valor: _matriculaController.text),
              _InfoItem(label: 'Nombre', valor: _nombreController.text),
              _InfoItem(label: 'Correo', valor: _correoController.text),
              _InfoItem(label: 'Carrera', valor: _carreraSeleccionada!),
              _InfoItem(label: 'Edad', valor: _edadController.text),
              _InfoItem(label: 'Sexo', valor: _sexoSeleccionado),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _limpiarFormulario();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _limpiarFormulario() {
    setState(() {
      _matriculaController.clear();
      _nombreController.clear();
      _correoController.clear();
      _edadController.clear();
      _carreraSeleccionada = null;
      _sexoSeleccionado = '';
      _aceptaTerminos = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Estudiante'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Icon(
                Icons.school,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _matriculaController,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                  hintText: 'Ej: 2024-0001',
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La matrícula es obligatoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  hintText: 'Ingresa tu nombre completo',
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'ejemplo@correo.com',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _carreraSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Carrera',
                  prefixIcon: Icon(Icons.book),
                ),
                items: _carreras.map((carrera) {
                  return DropdownMenuItem(value: carrera, child: Text(carrera));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _carreraSeleccionada = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecciona una carrera';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  hintText: 'Ej: 20',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  final edad = int.tryParse(value);
                  if (edad == null) {
                    return 'Debe ser un número válido';
                  }
                  if (edad <= 0) {
                    return 'La edad debe ser mayor que 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Sexo',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Card(
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Masculino'),
                      value: 'Masculino',
                      groupValue: _sexoSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _sexoSeleccionado = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Femenino'),
                      value: 'Femenino',
                      groupValue: _sexoSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _sexoSeleccionado = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: CheckboxListTile(
                  title: const Text('Acepto los términos y condiciones'),
                  subtitle: const Text('Es necesario aceptar para continuar'),
                  value: _aceptaTerminos,
                  onChanged: (value) {
                    setState(() {
                      _aceptaTerminos = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _registrar,
                icon: const Icon(Icons.save),
                label: const Text('Registrar'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _limpiarFormulario,
                icon: const Icon(Icons.clear),
                label: const Text('Limpiar formulario'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String valor;

  const _InfoItem({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
