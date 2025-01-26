$installPath = Join-Path -Path $PWD -ChildPath "miniconda"
$pythonPath = Join-Path -Path $installPath -ChildPath "envs\nlp_env\python.exe"

Write-Host "Python Path after activation:"
& $pythonPath --version

Write-Host "Running environment check..."
$env:HF_ENDPOINT = "https://hf-mirror.com"
& $pythonPath .\scripts\device_check.py
& $pythonPath .\scripts\model_check.py

Write-Host "Environment check completed!"
