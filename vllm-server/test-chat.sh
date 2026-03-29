#!/usr/bin/env bash
set -euo pipefail

curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "Qwen/Qwen3-0.6B",
    "messages": [
      {"role": "system", "content": "You are a concise assistant. Do not output any <think> tags or internal reasoning. Answer directly."},
      {"role": "user", "content": "Give me 3 ideas for a Bollywood dance studio launch event."}
    ],
    "temperature": 0.7
  }'
