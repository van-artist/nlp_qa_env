import logging
import torch
import platform
import huggingface_hub as hub

hub.HUGGINGFACE_CO_RESOLVE_ENDPOINT = "https://hf-mirror.com"

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")

logging.info("Starting hardware and environment detection...")

logging.info(f"System: {platform.system()} {platform.release()}")
logging.info(f"Machine: {platform.machine()}")
logging.info(f"Processor: {platform.processor()}")

if torch.cuda.is_available():
    logging.info(f"CUDA is available: {torch.cuda.is_available()}")
    logging.info(f"GPU Name: {torch.cuda.get_device_name(0)}")
    logging.info(f"CUDA Version: {torch.version.cuda}")
else:
    logging.info("CUDA is not available. Running on CPU.")

logging.info(f"PyTorch Version: {torch.__version__}")
logging.info("Hardware and environment detection completed.")
