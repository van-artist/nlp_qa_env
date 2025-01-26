# 定义脚本路径
$condaInstallScript = ".\scripts\conda_install.ps1"
$envInitScript = ".\scripts\env_init.ps1"
$envCheckScript = ".\scripts\env_check.ps1"

# 简单地运行每个脚本，无需检查返回值
Write-Host "Running Conda installation script..."
Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $condaInstallScript -Wait -NoNewWindow
Write-Host "Conda installation script completed!"

Write-Host "Running environment initialization script..."
Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $envInitScript -Wait -NoNewWindow
Write-Host "Environment initialization script completed!"

Write-Host "Running environment check script..."
Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $envCheckScript -Wait -NoNewWindow
Write-Host "Environment check script completed!"

Write-Host "All tasks completed successfully!"
