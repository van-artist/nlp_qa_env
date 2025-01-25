@echo off
cls
echo [INFO] Activating environment and running code...

call "%~dp0miniconda\Scripts\conda.exe" init
call "%~dp0miniconda\Scripts\conda.exe" activate nlp_env

if not exist "%~dp0src\main.py" (
    echo [ERROR] No main.py found in the "src" folder. Please ensure it exists and try again.
    pause
    exit /b 1
)

echo [INFO] Running src/main.py...
call "%~dp0miniconda\envs\nlp_env\python.exe" "%~dp0src\main.py"

echo [INFO] Execution completed successfully!
pause
