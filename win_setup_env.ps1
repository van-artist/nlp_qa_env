$condaInstallScript = ".\scripts\conda_install.ps1"
$envInitScript = ".\scripts\env_init.ps1"
$envCheckScript = ".\scripts\env_check.ps1"

if (-Not (Test-Path $condaInstallScript)) {
    Write-Host "Error: Conda installation script ($condaInstallScript) not found!"
    exit 1
}

if (-Not (Test-Path $envInitScript)) {
    Write-Host "Error: Initialization script ($envInitScript) not found!"
    exit 1
}

if (-Not (Test-Path $envCheckScript)) {
    Write-Host "Error: Check script ($envCheckScript) not found!"
    exit 1
}

Write-Host "Running Conda installation script..."
& $condaInstallScript

Write-Host "Running environment initialization script..."
& $envInitScript

Write-Host "Running environment check script..."
& $envCheckScript

Write-Host "All tasks completed successfully!"
