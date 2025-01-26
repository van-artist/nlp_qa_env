$installPath = Join-Path -Path $PWD -ChildPath "miniconda"
$condaExe = Join-Path -Path $installPath -ChildPath "Scripts\conda.exe"
$pythonPath = Join-Path -Path $installPath -ChildPath "envs\nlp_env\python.exe"

Write-Host "Creating Conda environment 'nlp_env'..."
Start-Process -FilePath $condaExe -ArgumentList "create", "-n", "nlp_env", "python=3.10", "-y" -Wait

Write-Host "Installing dependencies in Conda environment..."
& $pythonPath -m pip install torch transformers huggingface-hub -i https://pypi.tuna.tsinghua.edu.cn/simple

Write-Host "Dependencies installed successfully!"
