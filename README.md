# powershell-dotfiles

Configuración personal para Windows PowerShell con dos perfiles separados (`personal` y `professional`), instalación de herramientas CLI modernas, oh-my-posh para prompt, y módulos PowerShell útiles para flujo de trabajo dev.

## Lo que instala

- **Gestor de paquetes**: Scoop
- **CLI modernas (vía Scoop)**: `curl`, `sudo`, `jq`, `neovim`, `fzf`, `bat`, `ripgrep`, `fd`, `btop`, `delta`
- **Prompt**: oh-my-posh con tema personalizado por perfil
- **Módulos PowerShell**: posh-git, Terminal-Icons, z, PSReadLine (con prediction list view), PSFzf

## Estructura

```
.
├── install.ps1                       # Instalador idempotente — requiere -Profile
├── PersonalSettings/
│   ├── PowerShell - Docs/
│   │   └── Microsoft.PowerShell_profile.ps1   # Bootstrap (carga user_profile)
│   └── powershell - raiz/
│       ├── user_profile.ps1                   # Configuración real
│       └── personal-conf.omp.json             # Tema oh-my-posh (sobrio)
└── ProfesionalSettings/
    ├── PowerShell - Docs/
    │   └── Microsoft.PowerShell_profile.ps1
    └── powershell - raiz/
        ├── user_profile.ps1
        └── am.omp.json                        # Tema oh-my-posh (más elaborado)
```

## Instalación

**Importante**: el script requiere el parámetro `-Profile`. Si no lo proporcionas, falla con un mensaje de error. No hay default.

```powershell
# Clonar el repo
git clone git@github.com:MendicantBias-096/powershell-dotfiles.git $env:USERPROFILE\dotfiles
cd $env:USERPROFILE\dotfiles

# Aplicar perfil personal
.\install.ps1 -Profile personal

# O aplicar perfil profesional
.\install.ps1 -Profile professional
```

El instalador:

1. Instala Scoop si falta.
2. Instala herramientas CLI vía Scoop (idempotente, salta lo ya instalado).
3. Instala oh-my-posh si falta.
4. Instala los módulos PowerShell necesarios.
5. Crea los directorios `~/.config/PowerShell/` y `~/Documents/PowerShell/`.
6. Copia los archivos del perfil elegido a las rutas correctas.

Después: cierra y vuelve a abrir PowerShell para que cargue el nuevo perfil.

## Cómo funciona la carga del perfil

PowerShell lee automáticamente `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` al iniciar. Ese archivo es solo un bootstrap de una línea:

```powershell
. $env:USERPROFILE\.config\PowerShell\user_profile.ps1
```

Que carga `~/.config/PowerShell/user_profile.ps1` (la configuración real) — el cual a su vez referencia el `.omp.json` del mismo directorio para el tema.

## Cambiar de perfil

Vuelve a correr el instalador con el otro flag:

```powershell
.\install.ps1 -Profile professional
```

El script reemplaza los archivos en `~/.config/PowerShell/` y `~/Documents/PowerShell/`.

## Repos hermanos

Cada plataforma tiene su propio repo dedicado:

| Repo | Propósito |
|------|-----------|
| **powershell-dotfiles** (este) | Windows PowerShell |
| [`mac-dotfiles`](https://github.com/MendicantBias-096/mac-dotfiles) | macOS — Laravel/PHP, Mobile dev |
| [`wsl-linux-dotfiles`](https://github.com/MendicantBias-096/wsl-linux-dotfiles) | WSL2 + Linux/VPS — zsh + Powerlevel10k |
| [`vscode-profiles`](https://github.com/MendicantBias-096/vscode-profiles) | VS Code — settings, profiles, snippets |
| [`claude-code-config`](https://github.com/MendicantBias-096/claude-code-config) | Claude Code — global settings, skills, hooks |
