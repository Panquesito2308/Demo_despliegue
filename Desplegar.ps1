param(
    [string]$RutaPHP = 'php',
    [switch]$IniciarServidor
)

$archivoOrigen = Join-Path $PSScriptRoot '.\origen\index.php'
$archivoDestino = Join-Path $PSScriptRoot '.\pruebas\index.php'

& $RutaPHP -l $archivoOrigen

if ($LASTEXITCODE -ne 0) {
    Write-Host "hay un error de sintaxis. No se publico el cambio."
    exit 1
}
Copy-Item $archivoOrigen $archivoDestino -Force -ErrorAction Stop
Write-Host "Version publicada en el ambiente de pruebas."

if ($IniciarServidor) {
    if (Test-Path 'C:\laragon\bin\php\php-8.3.30-Win32-vs16-x64\php.exe') {
        & 'C:\laragon\bin\php\php-8.3.30-Win32-vs16-x64\php.exe' -S localhost:8000 -t .\pruebas
    } else {
        & $RutaPHP -S localhost:8000 -t .\pruebas
    }
}