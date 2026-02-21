FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.11 python3.11-venv python3-pip git wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Ensure pip for python3.11 (use system pip installed via apt)
RUN python3.11 -m pip install --upgrade pip || true

# Install PyTorch (cu118). Verify the exact command on pytorch.org if needed.
RUN python3.11 -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Clone ComfyUI and install Python requirements
WORKDIR /opt
RUN git clone https://github.com/Comfy-Org/ComfyUI.git /opt/ComfyUI
WORKDIR /opt/ComfyUI
RUN python3.11 -m pip install -r requirements.txt || true \
#    && python3.11 -m pip install -r custom_nodes/ComfyUI_essentials/requirements.txt ||  true \
#    && python3.11 -m pip install -r custom_nodes/comfyui-impact-pack/requirements.txt ||  true \
#    && python3.11 -m pip install -r custom_nodes/comfyui-manager/requirements.txt ||  true \
#    && rm -rf /opt/ComfyUI/custom_nodes/*

EXPOSE 8188

VOLUME /workspace/models
VOLUME /workspace/output

CMD ["python3.11", "main.py", "--listen", "0.0.0.0", "--port", "8188", "--multi-user"]
