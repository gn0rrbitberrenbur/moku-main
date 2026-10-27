$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot 'moku'
$buildDir = Join-Path $sourceDir 'build'

Write-Output "[INFO] Running tests in build directory [$buildDir]."

Push-Location $buildDir
try {
    ctest --output-on-failure
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        [Console]::Error.WriteLine("[ERROR] Tests failed in [$buildDir] (exit code $exitCode).")
        exit $exitCode
    }
    Write-Output "[INFO] Tests completed successfully in [$buildDir]."
} finally {
    Pop-Location
}