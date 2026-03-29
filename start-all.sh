#!/bin/bash
set -euo pipefail

echo "Starting AI stack..."

docker network create ai-stack-network 2>/dev/null || true

bash "$HOME/ai-stack/vllm-server/start-container.sh"
bash "$HOME/ai-stack/searxng/start.sh"
bash "$HOME/ai-stack/open-webui/start.sh"

echo
echo "Containers started."
echo "Now start vLLM manually with:"
echo
echo "docker exec -it vllm_rocm_container bash -lc 'cd /workspace/vllm-server && ./start-vllm-qwen4b.sh'"
echo
echo "Then test with:"
echo "curl http://localhost:8000/v1/models"
echo
echo "WebUI:   http://localhost:3000"
echo "SearXNG: http://localhost:8081"
