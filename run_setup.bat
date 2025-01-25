@echo off
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0win_setup_env.ps1"
pause

:: 激活 Conda 环境
call "%~dp0miniconda\condabin\conda.bat" activate nlp_env

:: 切换到项目目录
cd /d "%~dp0"