from transformers import AutoTokenizer, AutoModel, pipeline
import logging
from config import TEST_STR
import huggingface_hub as hub

hub.HUGGINGFACE_CO_RESOLVE_ENDPOINT = "https://hf-mirror.com"

def main():
    print("测试用户脚本")
    print(TEST_STR)
    # Use a pipeline as a high-level helper
    from transformers import pipeline

    messages = [
        {"role": "user", "content": "Who are you?"},
    ]
    pipe = pipeline("text-generation", model="deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B")
    result=pipe(messages)
    print(result)

if __name__ == "__main__":
    main()