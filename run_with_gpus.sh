#!/usr/bin/env bash
set -euo pipefail

# Build image with docker compose
docker compose build

# Run container with GPU access, mounts for models and outputs
docker run --rm -d \
  --gpus all \
  --name comfyui \
  -p 8188:8188 \
  -v "$(pwd)/models:/opt/ComfyUI/models" \
  -v "$(pwd)/output:/opt/ComfyUI/output" \
  comfyui:cu118

echo "ComfyUI container started (name=comfyui). Access the UI on http://localhost:8188"
