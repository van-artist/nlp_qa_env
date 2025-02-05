# 使用 Python 3.9 作为基础镜像，国内镜像源
FROM docker.1panel.live/library/python:3.9


# 设置工作目录
WORKDIR /app

# 安装必要的 Linux 依赖（Milvus 需要 OpenBLAS）
RUN apt-get update && apt-get install -y \
    wget curl libboost-all-dev supervisor && \
    rm -rf /var/lib/apt/lists/*

# 安装 Python 依赖
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN pip install --no-cache-dir \
    jupyter notebook \
    numpy pandas \
    torch transformers \
    matplotlib \
    pymilvus \
    llama-index \
    sentence-transformers \
    fastapi uvicorn

# 下载 Milvus 服务器
RUN wget https://github.com/milvus-io/milvus/releases/download/v2.4.0/milvus-linux-amd64.tar.gz && \
    tar -xvf milvus-linux-amd64.tar.gz && \
    mv milvus /milvus && \
    rm -rf milvus-linux-amd64.tar.gz

# 复制 Supervisor 配置文件
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 允许 Supervisor 启动多个进程
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
