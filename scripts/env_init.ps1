# 创建 Conda 环境
Write-Host "Creating Conda environment..."
.\miniconda\Scripts\conda.exe create -n nlp_env python=3.10 -y

# 激活环境
Write-Host "Activating Conda environment..."
& ".\miniconda\condabin\conda.bat" activate nlp_env

# 设置 Python 路径
$pythonPath = ".\miniconda\envs\nlp_env\python.exe"

# 检查 Python 路径是否存在
if (-Not (Test-Path $pythonPath)) {
    Write-Host "Error: Python executable not found in Conda environment!"
    exit 1
}

# 安装 pip 依赖
Write-Host "Installing dependencies using Pip..."
Start-Process -FilePath $pythonPath -ArgumentList "-m pip install torch" -NoNewWindow -Wait
Start-Process -FilePath $pythonPath -ArgumentList "-m pip install transformers" -NoNewWindow -Wait

# 验证安装
Write-Host "Verifying installations..."
Start-Process -FilePath $pythonPath -ArgumentList "-c `"import torch; print('PyTorch version:', torch.__version__)`"" -NoNewWindow -Wait
Start-Process -FilePath $pythonPath -ArgumentList "-c `"from transformers import pipeline; print('Transformers installed successfully!')`"" -NoNewWindow -Wait

Write-Host "Environment setup completed successfully!"
