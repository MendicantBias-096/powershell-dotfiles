# Instalar git          (Manual)
# Correr Maunalmente -> Install-Module posh-git -Scope CurrentUser -Force

# Instalar gcc          (Manual)
# Instalar VSCode       (Manual) 
# Instalar Discord      (Manual) 
# Instalar Notepad++    (Manual)
# Instalar Notion       (Manual)

# Instalar Navegadores  (Manual)
# - Chrome
# - Mozilla
# - Brave

# Instalar DBeaver      (Manual)
# Instalar HeidiSQL     (Manual)
# Instalar Zoom         (Manual)
# Instalamos Docker     (Manual)

"[ ----------------------------------------------]"
"[ ==> Instalamos el Gestor de paquetes Scope <==]"
"[ ----------------------------------------------]"
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
scoop install curl sudo jq

"[ ----------------------------------------------]"
"[ ============> Instalamos NeoVim <=============]"
"[ ----------------------------------------------]"
scoop install neovim

"[ ----------------------------------------------]"
"[ ============> Instalamos Oh-my-posh <=========]"
"[ ----------------------------------------------]"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

"[ -------------------------------------------------------------]"
"[ ============> Instalamos el modulo de Iconos <===============]"
"[ -------------------------------------------------------------]"
Install-Module -Name Terminal-Icons -Repository PSGallery -Force

"[ -----------------------------------------------------]"
"[ ============> Instalamos z Directory <===============]"
"[ -----------------------------------------------------]"
Install-Module -Name z -Force

"[ ----------------------------------------------------]"
"[ ============> Instalamos PSReadLine <===============]"
"[ ----------------------------------------------------]"
""
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

"[ ----------------------------------------------]"
"[ ============> Instalamos fzf <================]"
"[ ----------------------------------------------]"
scoop install fzf

"[ ------------------------------------------------]"
"[ ============> Instalamos PSFzf <================]"
"[ ------------------------------------------------]"
Install-Module -Name PSFzf -Scope CurrentUser -Force

"[ ----------------------------------------------]"
"[ ============> Instalamos bat <================]"
"[ ----------------------------------------------]"
scoop install bat