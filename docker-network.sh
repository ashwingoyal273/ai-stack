#!/bin/bash
docker network create ai-stack-network 2>/dev/null || true
echo "Docker network ready: ai-stack-network"
