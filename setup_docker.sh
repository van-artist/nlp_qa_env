#!/bin/bash

echo "🔹 检查 Docker 是否已安装..."
if ! command -v docker &>/dev/null; then
    echo "🚀 安装 Docker..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install --cask docker
        open -a Docker
    else
        sudo apt update && sudo apt install -y docker.io
        sudo systemctl start docker
        sudo systemctl enable docker
    fi
    echo "✅ Docker 安装完成！请重启电脑！"
    exit 0
fi

echo "✅ Docker 已安装，正在检查镜像加速器..."

# 配置 Docker 镜像加速器（仅影响当前用户）
mkdir -p ~/.docker
cat <<EOF >~/.docker/daemon.json
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com",
    "https://registry.aliyuncs.com"
  ]
}
EOF

echo "✅ 国内镜像加速器已配置！正在重启 Docker..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    open -a Docker
else
    sudo systemctl restart docker
fi

echo "🔹 拉取 Python 3.9 镜像..."
docker pull docker.1panel.live/library/python:3.9

echo "🔹 构建 Docker 镜像..."
docker build -t nlp_env .

echo "🔹 运行 Milvus + Jupyter..."
docker run -p 19530:19530 -p 8888:8888 --name milvus-container -d nlp_env

echo "✅ 运行成功！请访问 Jupyter Notebook: http://localhost:8888"
