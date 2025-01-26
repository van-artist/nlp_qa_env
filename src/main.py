# type: ignore
from transformers import pipeline
import logging
from config import TEST_STR
import huggingface_hub as hub

# 设置 Hugging Face Hub 镜像以提高访问速度
hub.HUGGINGFACE_CO_RESOLVE_ENDPOINT = "https://hf-mirror.com"
hub.HUGGINGFACE_CO_PREFIX = "https://hf-mirror.com"

def main():
    # 配置日志
    logging.basicConfig(level=logging.INFO)
    logging.info("启动对话机器人...")
    
    print("测试用户脚本")
    print(TEST_STR)

    # 初始化对话生成模型
    print("正在加载模型，这可能需要一些时间...")
    try:
        pipe = pipeline("text-generation", model="deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B")
    except Exception as e:
        logging.error("模型加载失败: %s", e)
        return

    print("模型加载成功！欢迎使用对话机器人。\n")
    print("输入 'exit' 退出对话。\n")

    # 简单的对话循环
    while True:
        user_input = input("你: ")
        if user_input.lower() == 'exit':
            print("对话结束，感谢使用！")
            break

        try:
            # 生成回复
            messages = [{"role": "user", "content": user_input}]
            result = pipe(messages, max_length=1000, num_return_sequences=1)
            response = result[0]['generated_text']

            print(f"机器人: {response}\n")
        except Exception as e:
            logging.error("生成回复失败: %s", e)
            print("机器人: 抱歉，我暂时无法处理你的请求。\n")

if __name__ == "__main__":
    main()
