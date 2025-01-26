@echo off
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0win_setup_env.ps1"
pause

:: 激活 Conda 环境
call "%~dp0Scripts\conda.exe" activate nlp_env

:: 切换到项目目录
cd /d "%~dp0"