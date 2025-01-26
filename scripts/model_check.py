# type: ignore
import logging
import torch
import torch.nn as nn
from transformers import AutoTokenizer, AutoModel, pipeline
import huggingface_hub as hub


hub.HUGGINGFACE_CO_RESOLVE_ENDPOINT = "https://hf-mirror.com"
# 配置日志格式
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler()
    ]
)

# RNN 测试
logging.info("Starting RNN Test...")
rnn = nn.RNN(input_size=10, hidden_size=20, num_layers=2, batch_first=True)
input_data = torch.randn(5, 3, 10)
output, hidden = rnn(input_data)
logging.info(f"RNN Test Successful. Output shape: {output.shape}")

# BERT 测试
logging.info("Starting BERT Test...")
model_name = "bert-base-uncased"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModel.from_pretrained(model_name)
inputs = tokenizer("Testing BERT model.", return_tensors="pt")
outputs = model(**inputs)
logging.info(f"BERT Test Successful. Hidden State shape: {outputs.last_hidden_state.shape}")

# Pipeline 测试
logging.info("Starting Text Generation Pipeline Test...")
messages = [{"role": "user", "content": "Who are you?"}]
pipe = pipeline("text-generation", model="deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B")
result = pipe(messages)
logging.info(f"Text Generation Test Successful. Result: {result}")
