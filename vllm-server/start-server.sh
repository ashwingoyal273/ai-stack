#!/bin/bash
set -euo pipefail

for i in {1..20}; do
  if [ "$(docker inspect -f '{{.State.Running}}' vllm_rocm_container 2>/dev/null || echo false)" = "true" ]; then
    break
  fi
  sleep 1
done

if [ "$(docker inspect -f '{{.State.Running}}' vllm_rocm_container 2>/dev/null || echo false)" != "true" ]; then
  echo "vLLM container is not running"
  exit 1
fi

docker exec vllm_rocm_container bash -lc '
pkill -f "vllm.entrypoints.openai.api_server" 2>/dev/null || true
cd /workspace/vllm-server
nohup ./start-vllm-qwen4b.sh >/tmp/vllm.log 2>&1 &
'

echo "vLLM server launch triggered"

for i in {1..30}; do
  if docker exec vllm_rocm_container bash -lc 'test -f /tmp/vllm.log'; then
    echo "vLLM log file created"
    exit 0
  fi
  sleep 1
done

echo "Warning: vLLM log file was not created yet"
exit 0
