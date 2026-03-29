#!/bin/bash
set -euo pipefail

docker rm -f open-webui searxng vllm_rocm_container 2>/dev/null || true
echo "Stopped open-webui, searxng, and vllm_rocm_container"
