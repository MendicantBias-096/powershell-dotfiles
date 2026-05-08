<#
.SYNOPSIS
  Instalador idempotente para powershell-dotfiles.

.DESCRIPTION
  Instala las herramientas necesarias (Scoop, módulos PowerShell, oh-my-posh)
  y aplica uno de los dos perfiles (personal o professional) copiando los
  archivos a las rutas correctas.

.PARAMETER Profile
  Perfil a aplicar. Valores aceptados: personal, professional.
  PARÁMETRO OBLIGATORIO — el script falla si no se proporciona.

.EXAMPLE
  .\install.ps1 -Profile personal

.EXAMPLE
  .\install.ps1 -Profile professional
#>

param(
    [string]$Profile = ""
)

$ErrorActionPreference = "Stop"

# ─── Validación del parámetro ────────────────────────────────────
if ($Profile -notin @("personal", "professional")) {
    Write-Host ""
    Write-Host "ERROR: Debes especificar el perfil." -ForegroundColor Red
    Write-Host ""
    Write-Host "Uso:" -ForegroundColor Yellow
    Write-Host "  .\install.ps1 -Profile personal"
    Write-Host "  .\install.ps1 -Profile professional"
    Write-Host ""
    exit 1
}

# ─── Helpers ─────────────────────────────────────────────────────
function Cyan ($msg)  { Write-Host $msg -ForegroundColor Cyan }
function Green ($msg) { Write-Host "  $msg" -ForegroundColor Green }
function Warn ($msg)  { Write-Host "  $msg" -ForegroundColor Yellow }

# ─── Mapear directorios fuente según el profile ──────────────────
$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

if ($Profile -eq "personal") {
    $SrcDir    = Join-Path $RepoDir "PersonalSettings"
    $ThemeFile = "personal-conf.omp.json"
} else {
    $SrcDir    = Join-Path $RepoDir "ProfessionalSettings"
    $ThemeFile = "professional-conf.omp.json"
}

$SrcRaiz = Join-Path $SrcDir "powershell - raiz"
$SrcDocs = Join-Path $SrcDir "PowerShell - Docs"

# Destinos finales en Windows
$ConfigDir = Join-Path $env:USERPROFILE ".config\PowerShell"
$DocsPSDir = Join-Path $env:USERPROFILE "Documents\PowerShell"

Cyan "→ Aplicando perfil: $Profile"

# ─── [1/6] SCOOP ─────────────────────────────────────────────────
Cyan "→ [1/6] Verificando Scoop..."
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    Green "Scoop instalado"
} else {
    Green "Scoop ya instalado"
}

# ─── [2/6] HERRAMIENTAS CLI ──────────────────────────────────────
Cyan "→ [2/6] Instalando herramientas CLI (Scoop)..."
$tools = @("curl", "sudo", "jq", "neovim", "fzf", "bat", "ripgrep", "fd", "btop", "delta")
foreach ($tool in $tools) {
    $installed = scoop list $tool 2>$null | Select-String -Pattern "^\s*$tool\s"
    if (-not $installed) {
        scoop install $tool
        Green "$tool instalado"
    } else {
        Green "$tool ya instalado"
    }
}

# ─── [3/6] OH-MY-POSH ────────────────────────────────────────────
Cyan "→ [3/6] Verificando oh-my-posh..."
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    Green "oh-my-posh instalado"
} else {
    Green "oh-my-posh ya instalado"
}

# ─── [4/6] MÓDULOS POWERSHELL ────────────────────────────────────
Cyan "→ [4/6] Instalando módulos PowerShell..."
$modules = @("posh-git", "Terminal-Icons", "z", "PSReadLine", "PSFzf")
foreach ($mod in $modules) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Install-Module -Name $mod -Scope CurrentUser -Force -SkipPublisherCheck -AllowPrerelease:$($mod -eq "PSReadLine")
        Green "$mod instalado"
    } else {
        Green "$mod ya instalado"
    }
}

# ─── [5/6] DIRECTORIOS DE DESTINO ────────────────────────────────
Cyan "→ [5/6] Preparando directorios..."
New-Item -ItemType Directory -Force -Path $ConfigDir | Out-Null
New-Item -ItemType Directory -Force -Path $DocsPSDir | Out-Null
Green "Directorios listos"

# ─── [6/6] COPIAR ARCHIVOS DEL PERFIL ────────────────────────────
Cyan "→ [6/6] Copiando archivos del perfil..."
$ts = Get-Date -Format "yyyyMMdd-HHmmss"

# Backup del profile existente si no es symlink
$existingProfile = Join-Path $DocsPSDir "Microsoft.PowerShell_profile.ps1"
if ((Test-Path $existingProfile) -and -not (Get-Item $existingProfile).LinkType) {
    Copy-Item $existingProfile "$existingProfile.pre-install-$ts"
    Warn "Backup: Microsoft.PowerShell_profile.ps1 -> $existingProfile.pre-install-$ts"
}

# Copiar bootstrap (Documents/PowerShell)
Copy-Item (Join-Path $SrcDocs "Microsoft.PowerShell_profile.ps1") $DocsPSDir -Force

# Copiar perfil real + theme (.config/PowerShell)
Copy-Item (Join-Path $SrcRaiz "user_profile.ps1") $ConfigDir -Force
Copy-Item (Join-Path $SrcRaiz $ThemeFile)         $ConfigDir -Force

Green "Archivos copiados"

# ─── Cierre ──────────────────────────────────────────────────────
Write-Host ""
Write-Host "🎉 Instalación completa." -ForegroundColor Green
Write-Host "   Cierra y vuelve a abrir PowerShell."
Write-Host ""
Write-Host "Repos hermanos para otras plataformas:" -ForegroundColor Yellow
Write-Host "   * https://github.com/MendicantBias-096/mac-dotfiles"
Write-Host "   * https://github.com/MendicantBias-096/wsl-linux-dotfiles"
Write-Host "   * https://github.com/MendicantBias-096/vscode-profiles"
Write-Host "   * https://github.com/MendicantBias-096/claude-code-config"
