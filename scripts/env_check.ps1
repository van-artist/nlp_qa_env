# 强制激活 Miniconda 本地环境
& ".\miniconda\condabin\conda.bat" activate nlp_env

# 检查激活的 Python 路径
Write-Host "Python Path after activation:"
& ".\miniconda\envs\nlp_env\python.exe" --version

# 运行验证脚本
Write-Host "Running environment check..."
& ".\miniconda\envs\nlp_env\python.exe" ./scripts/device_check.py
& ".\miniconda\envs\nlp_env\python.exe" ./scripts/model_check.py
