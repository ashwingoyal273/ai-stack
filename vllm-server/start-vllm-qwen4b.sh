#!/bin/bash
set -euo pipefail

export HSA_ENABLE_DXG_DETECTION=1
export LD_LIBRARY_PATH=/opt/rocm/lib:${LD_LIBRARY_PATH:-}
export VLLM_USE_V1=1
export HIP_VISIBLE_DEVICES=0
export CUDA_VISIBLE_DEVICES=0
unset VLLM_LOGGING_LEVEL

PATCH_FILE="/opt/venv/lib/python3.12/site-packages/vllm/platforms/__init__.py"
if grep -q 'is_rocm = False' "$PATCH_FILE"; then
  sed -i 's/is_rocm = False/is_rocm = True/g' "$PATCH_FILE"
fi

python -m vllm.entrypoints.openai.api_server \
  --model Qwen/Qwen3-4B-Instruct-2507 \
  --dtype float16 \
  --gpu-memory-utilization 0.64 \
  --max-model-len 3000 \
  --host 0.0.0.0 \
  --port 8000 \
  --uvicorn-log-level warning
