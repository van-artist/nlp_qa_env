$installPath = Join-Path -Path $PWD -ChildPath "miniconda"

Write-Host "Downloading Miniconda installer..."
Invoke-WebRequest -Uri "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe" -OutFile "Miniconda3-latest-Windows-x86_64.exe"

Write-Host "Installing Miniconda to $installPath..."
Start-Process -FilePath ".\Miniconda3-latest-Windows-x86_64.exe" -ArgumentList "/InstallationType=JustMe", "/AddToPath=0", "/S", "/D=$installPath" -Wait

Remove-Item ".\Miniconda3-latest-Windows-x86_64.exe"

Write-Host "Miniconda installed successfully to $installPath!"
