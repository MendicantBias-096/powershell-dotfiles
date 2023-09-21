# Terminal PowerSehll

Configuración para la Terminal de PowerShell e instalación de aplicaciones y dependencias

## Implementación
Clonar el repositorio

Ejecutar el siguiente script para instalar aplicaciones y dependencias

```bash
  InstallTerminalSetting.ps1  
```
- Para especificar las dependencias a instalar puede editar el script a su preferencia
---
Identificar el espacio de trabajo
```bash
  Personal ➡ PersonalSettings
  Trabajo ➡ ProfesionallSettings
```
Crear dos carpetas en las siguientes rutas

```bash
  cd users/name_user/ ➡ mkdir .config
```
```bash
  cd users/name_user/Documents/ ➡ mkdir PowerShell
```
---
Copiar el contenido de las carpetas del repositorio dentro de las carpetas creadas de la siguiente manera

```bash
  powershell - raiz ➡ users/name_user/.config
```
```bash
  PowerShell - Docs ➡ users/name_user/Documents/PowerShell
```
- Copiar solo el contenido, no el directorio
---

Reinicia la terminal, y listo