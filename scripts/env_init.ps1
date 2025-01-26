$installPath = Join-Path -Path $PWD -ChildPath "miniconda"
$condaExe = Join-Path -Path $installPath -ChildPath "Scripts\conda.exe"
$condaActivateScript = Join-Path -Path $installPath -ChildPath "Scripts\conda.exe"

Write-Host "Creating Conda environment 'nlp_env'..."
Start-Process -FilePath $condaExe -ArgumentList "create", "-n", "nlp_env", "python=3.10", "-y" -Wait

Write-Host "Activating Conda environment..."
Start-Process -FilePath $condaActivateScript -ArgumentList "activate", "nlp_env" -Wait

Write-Host "Conda environment 'nlp_env' activated successfully!"
