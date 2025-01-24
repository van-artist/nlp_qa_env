# 定义脚本路径
$condaInstallScript = ".\scripts\conda_install.ps1"
$envInitScript = ".\scripts\env_init.ps1"
$envCheckScript = ".\scripts\env_check.ps1"

# 检查脚本是否存在
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

# 安装 Conda
Write-Host "Running Conda installation script..."
& $condaInstallScript

# 初始化环境
Write-Host "Running environment initialization script..."
& $envInitScript

# 检查环境
Write-Host "Running environment check script..."
& $envCheckScript

Write-Host "All tasks completed successfully!"
