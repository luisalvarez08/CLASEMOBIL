# 🚨 SOLUCIÓN: Espacio en Disco Insuficiente

## ⚠️ Problema Detectado

```
FileSystemException: writeFrom failed
OS Error: Espacio en disco insuficiente, errno = 112
```

**Estado del Disco C:**

- **Usado:** 222.91 GB
- **Libre:** 0.09 GB (90 MB) ⚠️
- **Total:** 223 GB
- **Archivos temporales:** 7.29 GB

**¡Solo tienes 90 MB libres! Necesitas al menos 2-3 GB para compilar Flutter.**

---

## 🔧 SOLUCIONES INMEDIATAS

### **Solución 1: Limpiar Archivos Temporales (MÁS RÁPIDA)**

#### **Paso 1: Ejecutar Disk Cleanup**

1. Presiona `Windows + R`
2. Escribe: `cleanmgr`
3. Presiona Enter
4. Selecciona el disco **C:**
5. Marca TODAS las opciones:
   - ✅ Archivos temporales de Internet
   - ✅ Archivos temporales
   - ✅ Papelera de reciclaje
   - ✅ Miniaturas
   - ✅ Archivos de registro de Windows
   - ✅ Archivos de actualización de Windows
6. Click en **Aceptar**
7. Confirma con **Eliminar archivos**

**Esto liberará aproximadamente 7-10 GB**

#### **Paso 2: Limpiar Archivos de Sistema**

1. Ejecuta Disk Cleanup de nuevo
2. Click en **Limpiar archivos de sistema**
3. Marca:
   - ✅ Instalaciones anteriores de Windows
   - ✅ Archivos de actualización de Windows
4. Click en **Aceptar**

**Esto puede liberar 10-20 GB adicionales**

---

### **Solución 2: Limpiar Caché de Flutter**

Ya ejecutado automáticamente:

```bash
flutter clean
```

**Archivos eliminados:**

- ✅ build/
- ✅ .dart_tool/
- ✅ Archivos temporales de Flutter

---

### **Solución 3: Eliminar Archivos Grandes Manualmente**

#### **Encontrar archivos grandes:**

1. Abre **Explorador de archivos**
2. Ve a **Este equipo** → **Disco C:**
3. En la barra de búsqueda escribe: `size:>1GB`
4. Revisa y elimina archivos innecesarios

#### **Carpetas comunes con archivos grandes:**

- `C:\Users\[TuUsuario]\Downloads` - Descargas
- `C:\Users\[TuUsuario]\Videos` - Videos
- `C:\Users\[TuUsuario]\AppData\Local\Temp` - Temporales
- `C:\Windows\Temp` - Temporales del sistema
- `C:\Windows\SoftwareDistribution\Download` - Actualizaciones de Windows

---

### **Solución 4: Desinstalar Programas Innecesarios**

1. Presiona `Windows + I` (Configuración)
2. Ve a **Aplicaciones** → **Aplicaciones y características**
3. Ordena por **Tamaño**
4. Desinstala programas que no uses

---

### **Solución 5: Mover Archivos a Otro Disco**

Si tienes otro disco (D:, E:, etc.):

1. Mueve carpetas grandes:
   - Documentos
   - Descargas
   - Videos
   - Imágenes

2. Cambia la ubicación de Descargas:
   - Click derecho en **Descargas**
   - **Propiedades** → **Ubicación**
   - **Mover** → Selecciona otra unidad

---

## 🚀 DESPUÉS DE LIBERAR ESPACIO

### **Paso 1: Verificar Espacio Disponible**

```bash
# En PowerShell
Get-PSDrive C
```

**Deberías tener al menos 2-3 GB libres**

### **Paso 2: Limpiar y Recompilar**

```bash
cd "c:\Users\Maria Alexandra\Desktop\diesapp"
flutter clean
flutter pub get
flutter run
```

---

## 📊 RECOMENDACIONES

### **Espacio Mínimo Recomendado:**

| Actividad             | Espacio Necesario |
| --------------------- | ----------------- |
| **Compilar Flutter**  | 2-3 GB            |
| **Desarrollo cómodo** | 5-10 GB           |
| **Sistema estable**   | 15-20 GB          |

### **Mantenimiento Regular:**

1. **Semanal:**
   - Vaciar papelera de reciclaje
   - Limpiar carpeta de Descargas

2. **Mensual:**
   - Ejecutar Disk Cleanup
   - Revisar archivos grandes

3. **Trimestral:**
   - Desinstalar programas no usados
   - Limpiar archivos de sistema

---

## 🔍 COMANDOS ÚTILES

### **Ver espacio en disco:**

```powershell
Get-PSDrive C | Select-Object Name, Used, Free
```

### **Ver archivos temporales:**

```powershell
Get-ChildItem -Path $env:TEMP -Recurse | Measure-Object -Property Length -Sum
```

### **Limpiar Flutter:**

```bash
flutter clean
flutter pub cache repair
```

### **Limpiar temporales de Flutter:**

```powershell
Remove-Item -Path "$env:TEMP\flutter_tools.*" -Recurse -Force
```

---

## ⚡ SOLUCIÓN RÁPIDA (5 MINUTOS)

1. **Ejecutar Disk Cleanup** (cleanmgr)
   - Marca todas las opciones
   - Libera ~7-10 GB

2. **Vaciar Papelera**
   - Click derecho en Papelera
   - "Vaciar papelera de reciclaje"

3. **Limpiar Descargas**
   - Abre carpeta Descargas
   - Elimina archivos viejos

4. **Ejecutar:**
   ```bash
   flutter clean
   flutter pub get
   ```

**¡Listo para compilar!**

---

## 🎯 DESPUÉS DE LIBERAR ESPACIO

### **Compilar la Aplicación:**

```bash
# Opción 1: Compilar para Android
flutter run

# Opción 2: Compilar para Web (usa menos espacio)
flutter run -d chrome

# Opción 3: Compilar para Windows
flutter run -d windows
```

---

## 📝 NOTAS IMPORTANTES

### **¿Por qué Flutter necesita tanto espacio?**

- **Compilación:** Genera archivos temporales grandes
- **Dependencias:** Descarga paquetes
- **Build:** Crea archivos de compilación
- **Cache:** Almacena datos temporales

### **¿Cómo evitar este problema?**

1. Mantén al menos **10 GB libres** en C:
2. Ejecuta `flutter clean` después de cada proyecto
3. Limpia archivos temporales regularmente
4. Mueve proyectos grandes a otro disco

---

## ✅ CHECKLIST DE LIMPIEZA

- [ ] Ejecutar Disk Cleanup (cleanmgr)
- [ ] Limpiar archivos de sistema
- [ ] Vaciar papelera de reciclaje
- [ ] Limpiar carpeta Descargas
- [ ] Ejecutar `flutter clean`
- [ ] Eliminar archivos temporales de Flutter
- [ ] Verificar espacio disponible (>2 GB)
- [ ] Intentar compilar de nuevo

---

## 🆘 SI NADA FUNCIONA

### **Opción 1: Compilar en Otro Disco**

Si tienes otro disco con más espacio:

```bash
# Mover proyecto a D:
xcopy "C:\Users\Maria Alexandra\Desktop\diesapp" "D:\diesapp" /E /I
cd D:\diesapp
flutter run
```

### **Opción 2: Usar Flutter Web (Menos Espacio)**

```bash
flutter run -d chrome
```

Web usa menos espacio que Android/Windows.

### **Opción 3: Compilar en la Nube**

- GitHub Codespaces
- Gitpod
- Replit

---

## 🎉 RESUMEN

**Problema:** Solo 90 MB libres en disco C:
**Solución:** Liberar al menos 2-3 GB
**Método más rápido:** Disk Cleanup (cleanmgr)
**Tiempo estimado:** 5-10 minutos

**Después de liberar espacio:**

```bash
flutter clean
flutter pub get
flutter run
```

**¡Tu aplicación compilará sin problemas!** 🚀

---

**Fecha:** 2025  
**Estado:** ⚠️ REQUIERE ACCIÓN INMEDIATA
