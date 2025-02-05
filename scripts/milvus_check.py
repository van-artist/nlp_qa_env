# type:ignore

from pymilvus import MilvusClient
import numpy as np
import os

# 确保db文件存在和文件夹存在
if not os.path.exists("./milvus_lite"):
    os.mkdir("./milvus_lite")
if not os.path.exists("./milvus_lite/milvus_demo.db"):
    open("./milvus_lite/milvus_demo.db", "w").close()

client = MilvusClient("./milvus_demo.db")
client.create_collection(
    collection_name="demo_collection",
    dimension=384  
)

docs = [
    "Artificial intelligence was founded as an academic discipline in 1956.",
    "Alan Turing was the first person to conduct substantial research in AI.",
    "Born in Maida Vale, London, Turing was raised in southern England.",
]

vectors = [[ np.random.uniform(-1, 1) for _ in range(384) ] for _ in range(len(docs)) ]
data = [ {"id": i, "vector": vectors[i], "text": docs[i], "subject": "history"} for i in range(len(vectors)) ]
res = client.insert(
    collection_name="demo_collection",
    data=data
)

res = client.search(
    collection_name="demo_collection",
    data=[vectors[0]],
    filter="subject == 'history'",
    limit=2,
    output_fields=["text", "subject"],
)
print(res)

res = client.query(
    collection_name="demo_collection",
    filter="subject == 'history'",
    output_fields=["text", "subject"],
)
print(res)

res = client.delete(
    collection_name="demo_collection",
    filter="subject == 'history'",
)
print(res)

# 删除db文件
os.remove("./milvus_lite/milvus_demo.db")
os.rmdir("./milvus_lite")
