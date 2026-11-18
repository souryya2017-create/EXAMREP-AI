@echo off
REM ============================================================
REM One-Click Launcher for ExamPrep AI
REM Starts Ollama service and launches the ExamPrep AI CLI
REM ============================================================
title ExamPrep AI - Launcher
color 0B

echo ============================================================
echo         Starting ExamPrep AI Local Environment...
echo ============================================================
echo.

REM 1. Check if Ollama is running
tasklist /fi "imagename eq ollama.exe" 2>NUL | find /i "ollama.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo [*] Starting Ollama server in background...
    start "" /B ollama serve
    REM Give Ollama 3 seconds to spin up
    timeout /t 3 /nobreak >NUL
) else (
    echo [OK] Ollama is already running.
)

REM 2. Launch the CLI
echo [*] Launching ExamPrep AI CLI...
echo.
cd /d "%~dp0.."
python cli\main_cli.py

pause
