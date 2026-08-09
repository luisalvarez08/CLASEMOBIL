import 'package:flutter/material.dart';
import '../app/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Flutter 10 Apps',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                    offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                   right: -50,
                      top: -50,
                      child: Icon(
                        Icons.apps,
                        size: 200,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
           ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecciona una aplicación',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                 '${_apps.length} aplicaciones disponibles',
             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isTablet ? 1.0 : 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final app = _apps[index];
                  return _AppCard(
                    number: index + 1,
                    icon: app['icon'] as IconData,
                    title: app['title'] as String,
                    description: app['description'] as String,
                    route: app['route'] as String,
                    color: app['color'] as Color,
                  );
                },
                childCount: _apps.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
         child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }

  static final List<Map<String, dynamic>> _apps = [
    {
      'icon': Icons.person,
      'title': 'Presentación',
      'description': 'Tarjeta de presentación',
      'route': AppRoutes.presentacion,
      'color': Colors.blue,
    },
    {
      'icon': Icons.people,
      'title': 'Contador',
      'description': 'Contador de personas',
      'route': AppRoutes.contador,
      'color': Colors.green,
    },
    {
      'icon': Icons.cake,
      'title': 'Edad',
      'description': 'Calculadora de edad',
      'route': AppRoutes.edad,
      'color': Colors.pink,
    },
    {
      'icon': Icons.attach_money,
      'title': 'Propinas',
      'description': 'Calculadora de propinas',
      'route': AppRoutes.propinas,
    'color': Colors.amber,
    },
    {
      'icon': Icons.thermostat,
      'title': 'Temperatura',
      'description': 'Conversor de temperatura',
      'route': AppRoutes.temperatura,
      'color': Colors.orange,
    },
    {
      'icon': Icons.traffic,
      'title': 'Semáforo',
      'description': 'Semáforo interactivo',
      'route': AppRoutes.semaforo,
      'color': Colors.red,
    },
    {
      'icon': Icons.school,
      'title': 'Estudiante',
      'description': 'Registro de estudiante',
      'route': AppRoutes.estudiante,
      'color': Colors.indigo,
    },
    {
      'icon': Icons.shopping_cart,
      'title': 'Compras',
      'description': 'Lista de compras',
      'route': AppRoutes.compras,
      'color': Colors.teal,
    },
    {
      'icon': Icons.store,
      'title': 'Productos',
   'description': 'Catálogo de productos',
      'route': AppRoutes.productos,
      'color': Colors.purple,
    },
    {
      'icon': Icons.task_alt,
      'title': 'Tareas',
      'description': 'Tareas pendientes',
      'route': AppRoutes.tareas,
      'color': Colors.cyan,
    },
  ];
}

class _AppCard extends StatelessWidget {
  final int number;
  final IconData icon;
  final String title;
  final String description;
  final String route;
  final Color color;

  const _AppCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
         colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
               size: 40,
                    color: color,
                  ),
             ),
              const SizedBox(height: 12),
                Container(
          padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
               color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'App $number',
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
             maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
           description,
                  style: TextStyle(
                  fontSize: 11,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
