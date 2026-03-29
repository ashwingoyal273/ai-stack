#!/usr/bin/env bash
set -euo pipefail

IMAGE="rocm/vllm-dev:rocm7.2.1_navi_ubuntu24.04_py3.12_pytorch_2.9_vllm_0.16.0"
NAME="vllm_rocm_container"
HOST_PROJECT="${HOME}/ai-stack/vllm-server"
CONTAINER_PROJECT="/workspace/vllm-server"
HF_CACHE="${HOME}/ai-stack/hf-cache"

mkdir -p "${HF_CACHE}"

docker rm -f "${NAME}" 2>/dev/null || true

docker run -it \
  --network=host \
  --group-add=video \
  --ipc=host \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  --device /dev/dxg \
  --entrypoint /bin/bash \
  -v /usr/lib/wsl/lib/libdxcore.so:/usr/lib/libdxcore.so \
  -v /opt/rocm/lib/libhsa-runtime64.so.1:/opt/rocm/lib/libhsa-runtime64.so.1 \
  -v /opt/rocm/lib/librocdxg.so:/opt/rocm/lib/librocdxg.so \
  -v /opt/rocm/lib/librocdxg.so.1:/opt/rocm/lib/librocdxg.so.1 \
  -v "${HOST_PROJECT}:${CONTAINER_PROJECT}" \
  -v "${HF_CACHE}:/root/.cache/huggingface" \
  -e HSA_ENABLE_DXG_DETECTION=1 \
  -e LD_LIBRARY_PATH=/opt/rocm/lib:${LD_LIBRARY_PATH:-} \
  -e VLLM_USE_V1=1 \
  -e HIP_VISIBLE_DEVICES=0 \
  -e CUDA_VISIBLE_DEVICES=0 \
  -w "${CONTAINER_PROJECT}" \
  --name "${NAME}" \
  "${IMAGE}"
