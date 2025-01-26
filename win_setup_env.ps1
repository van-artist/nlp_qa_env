# 定义脚本路径
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

function Run-Script {
    param (
        [string]$scriptPath,
        [string]$stepName
    )
    Write-Host "Starting $stepName..."
    try {
        Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $scriptPath -Wait -NoNewWindow
        if ($LASTEXITCODE -ne 0) {
            throw "$stepName failed with exit code $LASTEXITCODE"
        }
        Write-Host "$stepName completed successfully!"
    } catch {
        Write-Host "Error: $stepName encountered an issue. Details: $_"
        exit 1
    }
}

Run-Script -scriptPath $condaInstallScript -stepName "Conda installation script"
Run-Script -scriptPath $envInitScript -stepName "Environment initialization script"
Run-Script -scriptPath $envCheckScript -stepName "Environment check script"

Write-Host "All tasks completed successfully!"
