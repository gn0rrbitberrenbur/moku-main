$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoRoot 'moku'
$buildDir = Join-Path $sourceDir 'build'

Write-Output "[INFO] Running protocol tests in build directory [$buildDir]."

Push-Location $buildDir
try {
    ctest -C Release --output-on-failure -R "^GomocupProtocolTest\."
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        [Console]::Error.WriteLine("[ERROR] Protocol tests failed in [$buildDir] (exit code $exitCode).")
        exit $exitCode
    }
    Write-Output "[INFO] Protocol tests completed successfully in [$buildDir]."
} finally {
    Pop-Location
}