@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo        ExamPrep AI - Automated Environment Setup
echo ========================================================
echo.

REM 1. Verify Python Installation
echo [*] Checking Python installation...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python is not installed or not in system PATH.
    echo Please install Python 3.10+ from https://www.python.org/
    pause
    exit /b 1
)
echo [OK] Python found.

REM 2. Install Required Python Dependencies
echo.
echo [*] Installing required Python libraries...
python -m pip install --upgrade pip
python -m pip install -r backend\requirements.txt rich
if %ERRORLEVEL% NEQ 0 (
    echo [WARN] Some packages failed to install. Please review output above.
) else (
    echo [OK] Python libraries installed.
)

REM 3. Verify / Download Ollama
echo.
echo [*] Checking Ollama installation...
where ollama >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [-] Ollama not detected in PATH.
    echo [*] Downloading Ollama installer for Windows...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://ollama.com/download/OllamaSetup.exe' -OutFile 'OllamaSetup.exe'}"
    if exist "OllamaSetup.exe" (
        echo [*] Running Ollama installer. Complete the setup wizard...
        start /wait OllamaSetup.exe
        del OllamaSetup.exe
        echo [OK] Ollama installed. Please restart your shell if commands are not recognized.
    ) else (
        echo [ERROR] Automatic download failed. Please install Ollama manually from https://ollama.com
    )
) else (
    echo [OK] Ollama is already installed.
)

REM 4. Check Compiler (GCC)
echo.
echo [*] Checking C/C++ compiler...
where gcc >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [WARN] GCC not found in PATH.
    echo To compile and run C/C++ code locally, install MinGW-w64 or MSYS2.
) else (
    echo [OK] GCC found.
)

REM 5. Pull Base Model and Build Custom Exam Model
echo.
echo [*] Checking Ollama background service...
powershell -Command "try { (Invoke-WebRequest -Uri 'http://localhost:11434/' -TimeoutSec 2).StatusCode } catch { exit 1 }" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [*] Launching Ollama daemon...
    start "" /B ollama serve
    timeout /t 3 /nobreak >nul
)

echo [*] Pulling base model (qwen2.5:3b)...
ollama pull qwen2.5:3b

echo [*] Building custom model from Modelfile...
cd /d "%~dp0modelfile"
ollama create examprep-ai -f Modelfile
cd /d "%~dp0"

echo.
echo ========================================================
echo        Setup Complete! You are ready to start.
echo   Run 'start.bat' or 'python cli\main_cli.py' to launch.
echo ========================================================
pause
