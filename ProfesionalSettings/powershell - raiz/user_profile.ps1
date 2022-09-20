# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Icons
Import-Module -Name Terminal-Icons

# Prompt
Import-module posh-git

# Load promopt config
$omp_config = Join-Path $PSScriptRoot ".\am.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
# Estamos colocando comandos con alias, nada más.
Set-Alias vim nvim 
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig "C:\Program Files\Git\usr\bin\tig.exe" 
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"

# Utilities
function which($name) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
