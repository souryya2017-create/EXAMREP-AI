# ExamPrep AI — University Coding Practice & Exam Platform

ExamPrep AI is a production-oriented coding practice and examination platform inspired by university assessment environments (Neo Browser, CodeTantra), featuring an isolated C/C++ compiler and a local AI assistant powered by Ollama.

---

## Features
- **Monaco Editor IDE**: Professional dark-themed UI with multi-panel layout, syntax highlighting, and custom I/O.
- **Isolated Execution Engine**: C11 and C++17 compilation via GCC/G++ with memory caps, process timeouts, and restricted syscalls.
- **Automated Test Evaluator**: Visible and hidden test-case verification returning standard competitive programming verdicts (AC, WA, TLE, MLE, RE, CE).
- **Verified AI Debugger**: Re-compiles and executes AI-suggested code corrections to prevent hallucinated fixes.
- **RAG Document Indexing**: Vector-search notes and course materials using ChromaDB.
- **AI Security Guardrails**: Detects prompt injection, masks PII, and blocks unsafe system calls.
- **Docker Ready**: Preconfigured Dockerfile and docker-compose.yml.

---

## Quick Start

### 1. Requirements
* Python 3.10+
* GCC and G++ (with C11 and C++17 support)
* Ollama (`ollama pull qwen2.5:3b`)

### 2. Setup & Run
```bash
# 1. Install dependencies
cd backend
pip install -r requirements.txt

# 2. Start Ollama model
ollama serve
ollama pull qwen2.5:3b

# 3. Start ExamPrep AI
cd ..
scripts\start_backend.bat
```

Open your browser to:
* **IDE & Coding Workspace**: `http://localhost:8000/`
* **Swagger API Docs**: `http://localhost:8000/docs`
