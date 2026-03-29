#!/bin/bash
set -euo pipefail

docker rm -f open-webui 2>/dev/null || true

docker run -d \
  --name open-webui \
  --network ai-stack-network \
  --restart unless-stopped \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui-data:/app/backend/data \
  ghcr.io/open-webui/open-webui:v0.8.6

echo "Open WebUI started at http://localhost:3000"
echo "Model endpoint to use in WebUI: http://host.docker.internal:8000/v1"
echo "SearXNG URL to use in WebUI: http://searxng:8080/search?q=<query>&format=json"
