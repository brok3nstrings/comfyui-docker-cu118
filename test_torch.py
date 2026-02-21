import torch
print('torch version:', torch.__version__)
print('cuda_available:', torch.cuda.is_available())
print('cuda_version:', torch.version.cuda)
if torch.cuda.is_available():
    try:
        print('device:', torch.cuda.get_device_name(0))
    except Exception as e:
        print('device name error:', e)
