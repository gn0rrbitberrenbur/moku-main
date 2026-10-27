$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot 'moku'
$buildDir = Join-Path $sourceDir 'build'

cmake -S $sourceDir -B $buildDir -DCMAKE_BUILD_TYPE=Release
$exitCode = $LASTEXITCODE
if ($exitCode -ne 0)
{
    [Console]::Error.WriteLine("[ERROR] CMake configuration failed for [$buildDir] (exit code $exitCode).")
    exit $exitCode
}

Write-Output "[INFO] CMake configuration was successful."
Write-Output "[INFO] Starting build process."

cmake --build $buildDir --config Release
$exitCode = $LASTEXITCODE
if ($exitCode -ne 0)
{
    [Console]::Error.WriteLine("[ERROR] Build failed in [$buildDir] (exit code $exitCode).")
    exit $exitCode
}

Write-Output "[INFO] Build completed successfully in [$buildDir]."