# ComfyUI (Docker) — Pascal GPU Support (CUDA 11.8) setup

Minimal Docker setup to run ComfyUI using the host NVIDIA driver + NVIDIA Container Toolkit and PyTorch built for CUDA 11.8.

Prerequisites (host):
- Ubuntu 24.04 with NVIDIA driver
- Docker installed
- nvidia-container-toolkit installed and Docker configured to use it


Build and run (from this folder):

```bash
# Build the image with docker compose
docker compose build

# Run using the helper script which starts the image with GPU access
./run_with_gpus.sh

# (Alternative) Build image only and run directly with docker:
docker build -t comfyui:cu118 .
docker run --rm --gpus all -p 8188:8188 -v $(pwd)/models:/opt/ComfyUI/models -v $(pwd)/outputs:/opt/ComfyUI/output comfyui:cu118
```

Quick verification inside container (after container is up):

```bash
# Example: run the tiny PyTorch test inside the running container
docker exec -it comfyui python3.11 -c "import torch; print(torch.__version__, torch.cuda.is_available(), torch.version.cuda, torch.cuda.get_device_name(0))"

# Or follow logs to see ComfyUI startup
docker logs -f comfyui
```

Notes & tips
- This Dockerfile installs PyTorch with the `cu118` wheel. If PyTorch site changes wheel locations, update the `pip install` line accordingly (see https://pytorch.org/get-started/locally/).
- We clone `ComfyUI` into `/opt/ComfyUI`. Mounting `./ComfyUI` into the container (via docker-compose) lets you iterate on local changes.
- Store large models in `./models` on the host to avoid rebuilding images.

If you want, I can now build the image here and run the container to verify PyTorch+CUDA and the ComfyUI startup.
