& ".\miniconda\condabin\conda.bat" activate nlp_env

Write-Host "Python Path after activation:"
& ".\miniconda\envs\nlp_env\python.exe" --version

Write-Host "Setting Hugging Face domestic mirror source..."
$env:HF_HUB_ENABLE_HF_PROXY = "true"
$env:HF_HUB_PROXY = "https://huggingface.co"

Write-Host "Running environment check..."
& ".\miniconda\envs\nlp_env\python.exe" ./scripts/device_check.py
& ".\miniconda\envs\nlp_env\python.exe" ./scripts/model_check.py
