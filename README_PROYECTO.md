# Flutter 10 Apps

Una aplicación Flutter que contiene 10 aplicaciones internas funcionales, diseñada como proyecto educativo.

## 📱 Aplicaciones Incluidas

1. **Tarjeta de Presentación** - Muestra información personal con diseño profesional
2. **Contador de Personas** - Contador con capacidad máxima y validaciones
3. **Calculadora de Edad** - Calcula la edad basada en el año de nacimiento
4. **Calculadora de Propinas** - Calcula propinas con diferentes porcentajes
5. **Conversor de Temperatura** - Convierte entre Celsius y Fahrenheit
6. **Semáforo Interactivo** - Simulación de semáforo con estados
7. **Registro de Estudiante** - Formulario completo con validaciones
8. **Lista de Compras** - Gestión de productos con estado de comprado
9. **Catálogo de Productos** - Visualización y detalle de productos
10. **Tareas Pendientes** - Gestor de tareas con prioridades y fechas

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada
├── app/
│   ├── app.dart                       # Configuración de la app
│   ├── routes.dart                    # Rutas nombradas
│   └── theme.dart                     # Tema centralizado
├── home/
│   └── home_screen.dart               # Pantalla principal con menú
└── apps/
    ├── presentacion/
    │   └── presentacion_screen.dart
    ├── contador/
    │   └── contador_screen.dart
    ├── edad/
    │   └── edad_screen.dart
    ├── propinas/
    │   └── propinas_screen.dart
    ├── temperatura/
    │   └── temperatura_screen.dart
    ├── semaforo/
    │   └── semaforo_screen.dart
    ├── estudiante/
    │   └── estudiante_screen.dart
    ├── compras/
    │   └── compras_screen.dart
    ├── productos/
    │   ├── models/
    │   │   └── producto.dart
    │   ├── productos_screen.dart
    │   └── producto_detalle_screen.dart
    └── tareas/
        ├── models/
        │   └── tarea.dart
        ├── tareas_screen.dart
        └── tarea_form_screen.dart
```

## 🚀 Cómo Ejecutar

### Requisitos Previos

- Flutter SDK (versión 3.12.2 o superior)
- Dart SDK
- Android Studio / VS Code con extensiones de Flutter
- Emulador Android o dispositivo físico

### Pasos

1. **Clonar o abrir el proyecto**

   ```bash
   cd diesapp
   ```

2. **Instalar dependencias**

   ```bash
   flutter pub get
   ```

3. **Verificar que no hay errores**

   ```bash
   flutter analyze
   ```

4. **Ejecutar la aplicación**

   ```bash
   flutter run
   ```

   O desde tu IDE:
   - VS Code: Presiona `F5`
   - Android Studio: Click en el botón "Run"

## 📦 Dependencias

- `flutter`: SDK de Flutter
- `cupertino_icons`: ^1.0.8 - Iconos de iOS
- `intl`: ^0.19.0 - Internacionalización y formateo de fechas

## ✨ Características

### Navegación

- Sistema de rutas nombradas
- Navegación fluida entre aplicaciones
- Botón de retroceso en todas las pantallas

### Diseño

- Material Design 3
- Tema centralizado y consistente
- Responsive y adaptable
- Interfaz moderna y limpia

### Funcionalidades

- Validación de formularios
- Gestión de estado con `setState`
- Diálogos de confirmación
- Formateo de fechas
- Persistencia de datos en memoria

## 🎯 Funcionalidades por Aplicación

### 1. Tarjeta de Presentación

- Avatar circular
- Información de contacto con iconos
- Diseño profesional con Cards

### 2. Contador de Personas

- Incrementar/Decrementar contador
- Validación de capacidad máxima (20 personas)
- Diálogo de confirmación para reiniciar
- No permite valores negativos

### 3. Calculadora de Edad

- Validación de nombre obligatorio
- Validación de año (1900 - año actual)
- Cálculo automático de edad
- Botón para limpiar formulario

### 4. Calculadora de Propinas

- Selección de porcentaje (5%, 10%, 15%, 20%)
- Cálculo de propina y total
- Formato de moneda (RD$)
- Validación de monto positivo

### 5. Conversor de Temperatura

- Conversión Celsius ↔ Fahrenheit
- Validación de entrada numérica
- Resultado con 2 decimales
- Limpieza automática al cambiar tipo

### 6. Semáforo Interactivo

- Tres estados: Rojo, Verde, Amarillo
- Orden correcto: Rojo → Verde → Amarillo → Rojo
- Mensajes contextuales
- Animación visual de luces

### 7. Registro de Estudiante

- Formulario completo con validaciones
- Dropdown para selección de carrera
- RadioButtons para sexo
- Checkbox para términos y condiciones
- Diálogo con resumen de registro

### 8. Lista de Compras

- Agregar productos
- Marcar como comprado (con tachado)
- Eliminar productos individuales
- Eliminar todos los comprados
- Estadísticas en tiempo real

### 9. Catálogo de Productos

- Grid de productos
- Navegación a detalle
- Información completa del producto
- Diseño tipo e-commerce

### 10. Tareas Pendientes

- Crear, editar y eliminar tareas
- Prioridades: Baja, Media, Alta
- Selector de fecha límite
- Marcar como completada
- Estadísticas de tareas

## 🔍 Análisis de Código

El proyecto pasa `flutter analyze` con solo warnings de deprecación menores relacionados con:

- `RadioListTile` (groupValue/onChanged) - Funcional en versión actual
- `withOpacity` - Funcional, nueva API disponible en versiones futuras
- `DropdownButtonFormField.value` - Funcional, nueva API disponible

Estos warnings no afectan la funcionalidad de la aplicación.

## 📝 Notas Importantes

- **Arquitectura modular**: Cada aplicación está en su propia carpeta
- **Código limpio**: Sin duplicación innecesaria
- **Validaciones completas**: Todos los formularios tienen validación
- **Navegación consistente**: Todas las pantallas permiten regresar
- **Sin dependencias externas pesadas**: Solo lo esencial

## 🎓 Propósito Educativo

Este proyecto fue diseñado para demostrar:

- Organización de proyectos Flutter
- Navegación entre pantallas
- Gestión de estado
- Validación de formularios
- Diseño de interfaces
- Buenas prácticas de código

## 👨‍💻 Desarrollo

Proyecto desarrollado como ejercicio educativo integrando 10 aplicaciones en una sola app Flutter.

---

**Versión**: 1.0.0  
**Flutter SDK**: ^3.12.2  
**Última actualización**: 2025
