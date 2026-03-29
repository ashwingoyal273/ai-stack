# 🚀 AI Stack — Local Personal AI Assistant

A fully local, reproducible AI assistant stack powered by:

- ⚡ vLLM (fast local inference)
- 🧠 AMD GPU via ROCm (WSL)
- 💬 Open WebUI (chat interface)
- 🔍 SearXNG (self-hosted web search)

This project builds a local-first AI assistant that runs on your machine, supports real-time web search, streams responses, and provides a foundation for agentic workflows.

---

## 🧠 Architecture

Browser (localhost:3000)
        ↓
   Open WebUI
        ↓
vLLM (OpenAI-compatible API)
        ↓
Local Model (AMD GPU via ROCm)

Web Search:
Open WebUI → SearXNG → Internet

---

## ✨ Features

- Local LLM inference using vLLM  
- AMD GPU acceleration via ROCm on WSL  
- OpenAI-compatible API  
- Web search via SearXNG  
- Streaming responses  
- Reproducible Docker-based setup  

Planned:
- Tool calling / agent workflows  
- Custom tools (finance, weather, etc.)  
- Memory (RAG)  
- Multi-model routing  

---

## 📁 Project Structure

ai-stack/
├── open-webui/
│   ├── start.sh
│   └── data/
├── searxng/
│   ├── settings.yml
│   └── start.sh
├── vllm-server/
│   ├── start-container.sh
│   ├── start-server.sh
│   └── start-vllm-qwen4b.sh
├── docker-network.sh
├── start-all.sh
├── stop-all.sh
└── README.md

---

## ⚙️ Requirements

- Windows + WSL2  
- Ubuntu (tested on 24.04)  
- AMD GPU with ROCm support  
- Docker in WSL  
- ROCm + librocdxg configured  
- ~16GB VRAM recommended  

---

## 🚀 Quick Start

Start all containers:

bash ~/ai-stack/start-all.sh

Start the model server:

docker exec -it vllm_rocm_container bash -lc 'cd /workspace/vllm-server && ./start-vllm-qwen4b.sh'

Verify:

curl http://localhost:8000/v1/models

Open UI:

http://localhost:3000

---

## 🔗 Open WebUI Configuration

Base URL: http://host.docker.internal:8000/v1  
API Key: local-key  

Search URL:  
http://searxng:8080/search?q=<query>&format=json  

---

## 🧠 Model

Qwen/Qwen3-4B-Instruct-2507

---

## 🧠 System Prompt

You are a smart, reliable, and web-connected personal AI assistant.

Use web search for anything time-sensitive.  
Summarize results clearly.  
Do not refuse if data is available.  
Do not output internal reasoning.  

---

## 🛑 Stop

bash ~/ai-stack/stop-all.sh

---

## 💾 Persistence

~/ai-stack/open-webui/data

---

## 🧪 Debug

docker exec -it vllm_rocm_container bash -lc 'tail -f /tmp/vllm.log'

curl http://localhost:8000/v1/models  
curl "http://localhost:8081/search?q=AI&format=json"

---

## 🧠 Philosophy

- Single-user focused  
- Optimized for latency  
- Fully local  
- Modular  

---

## 🔮 Roadmap

- Tool calling  
- Custom tools  
- Memory (RAG)  
- Multi-model routing  

---

## 🧑‍💻 Author

Ashwin Goyal
