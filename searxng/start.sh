#!/bin/bash
set -euo pipefail

docker rm -f searxng 2>/dev/null || true

docker run -d \
  --name searxng \
  --network ai-stack-network \
  --restart unless-stopped \
  -p 8081:8080 \
  -v "$HOME/ai-stack/searxng:/etc/searxng:rw" \
  searxng/searxng:latest

echo "SearXNG started at http://localhost:8081"
