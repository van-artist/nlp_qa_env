#!/bin/bash

echo "🔹 检查 Docker 是否正在运行..."
if (! docker stats --no-stream); then
    echo "❌ Docker 没有启动，请手动打开 Docker Desktop。"
    exit 1
fi

echo "🔹 构建 Milvus + Jupyter Docker 镜像..."
docker build -t nlp_qa .

echo "🔹 运行 Milvus + Jupyter 容器..."
docker run -p 19530:19530 -p 8888:8888 --name milvus-container -d nlp_qa

echo "✅ 运行成功！请访问 Jupyter Notebook: http://localhost:8888"
