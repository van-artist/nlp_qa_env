& ".\miniconda\condabin\Scripts\conda.exe" activate nlp_env

Write-Host "Python Path after activation:"
& ".\miniconda\envs\nlp_env\python.exe" --version

Write-Host "Setting Hugging Face domestic mirror source..."

Write-Host "Running environment check..."
$env:HF_HUB_ENABLE_HF_PROXY = "true"
$env:HF_ENDPOINT = "https://hf-mirror.com"
& ".\miniconda\envs\nlp_env\python.exe" ./scripts/device_check.py
& ".\miniconda\envs\nlp_env\python.exe" ./scripts/model_check.py
