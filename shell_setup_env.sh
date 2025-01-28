#!/usr/bin/env bash

# 确保脚本执行时遇到错误就终止
set -e

########################################
#          1. 变量定义与创建目录
########################################

# 工作区目录：在当前脚本所在路径下建立 nlp_workspace
WORKSPACE_DIR="$(pwd)"
SCRIPTS_DIR="$WORKSPACE_DIR/scripts"

# Miniconda 安装路径
MINICONDA_DIR="$WORKSPACE_DIR/miniconda"
# Conda 环境名称
ENV_NAME="nlp_course_env"

DEVICE_CHECK_PATH="$SCRIPTS_DIR/device_check.py"
MODEL_CHECK_PATH="$SCRIPTS_DIR/model_check.py"

echo "=================================================="
echo " NLP 实践课程环境配置脚本 (macOS)"
echo "=================================================="

# 创建工作区目录（若不存在）
if [ ! -d "$WORKSPACE_DIR" ]; then
    echo "=> 创建工作区目录: $WORKSPACE_DIR"
    mkdir -p "$WORKSPACE_DIR"
else
    echo "=> 工作区目录已存在: $WORKSPACE_DIR"
fi

########################################
#          2. 检查系统 Conda
########################################

if command -v conda &>/dev/null; then
    echo "=> 系统已检测到 Conda 安装。"
    echo "   Conda 版本: $(conda --version)"
    CONDA_INSTALLED=true
    # 系统 Conda 的基路径
    CONDA_BASE_DIR="$(conda info --base)"
else
    echo "=> 系统未检测到 Conda，正在下载并安装 Miniconda 到工作区..."
    curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh \
        -o "$WORKSPACE_DIR/Miniconda3-latest-MacOSX.sh"
    bash "$WORKSPACE_DIR/Miniconda3-latest-MacOSX.sh" -b -p "$MINICONDA_DIR"
    echo "=> Miniconda 安装完成。"
    # 设置脚本内环境变量
    export PATH="$MINICONDA_DIR/bin:$PATH"
    CONDA_INSTALLED=false
    CONDA_BASE_DIR="$MINICONDA_DIR"
fi

# 方便后续统一调用：conda 命令路径
CONDA_EXE="$CONDA_BASE_DIR/bin/conda"

########################################
#          3. 处理 Conda 环境
########################################

# 检查目标环境是否存在
ENV_EXISTS=$($CONDA_EXE info --envs | awk '{print $1}' | grep -x "$ENV_NAME" || echo "")

if [ -n "$ENV_EXISTS" ]; then
    # 环境已存在，直接复用（或按需求进行补充安装）
    echo "=> Conda 环境 '$ENV_NAME' 已存在，将直接使用该环境。"
else
    # 若不存在则创建新的环境
    echo "=================================================="
    echo "=> 创建 Conda 环境: $ENV_NAME"
    $CONDA_EXE create -n "$ENV_NAME" python=3.9 -y
fi

########################################
#          4. 激活环境 & 配置镜像
########################################

echo "=================================================="
echo "=> 激活 Conda 环境: $ENV_NAME"
if [ "$CONDA_INSTALLED" = true ]; then
    # 使用系统 Conda
    source "$CONDA_BASE_DIR/bin/activate" "$ENV_NAME"
else
    # 使用本脚本安装的 Miniconda
    source "$MINICONDA_DIR/bin/activate" "$ENV_NAME"
fi

# 配置国内镜像
echo "=================================================="
echo "=> 配置国内镜像以加速安装..."
# Conda 镜像设置（清华镜像）
$CONDA_EXE config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
$CONDA_EXE config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
$CONDA_EXE config --set show_channel_urls yes

# pip 镜像设置（豆瓣镜像）
mkdir -p ~/.pip
cat >~/.pip/pip.conf <<EOF
[global]
index-url = https://pypi.doubanio.com/simple/
timeout = 600
EOF

########################################
#          5. 安装依赖
########################################

echo "=================================================="
echo "=> 安装 PyTorch 和相关依赖..."
pip install torch

echo "=> 安装 Transformers 和 Hugging Face 工具..."
pip install --upgrade pip
pip install --upgrade transformers accelerate huggingface-hub

########################################
#          6. 验证安装
########################################

echo "=================================================="
echo "=> 验证 PyTorch & Transformers 安装"
python -c "import torch, transformers; print('PyTorch:', torch.__version__, 'Transformers:', transformers.__version__)"

echo "=> 执行检察脚本..."

export HUGGINGFACE_CO_URL_OVERRIDE=https://hf-mirror.com
export HF_ENDPOINT=https://hf-mirror.com
python "$DEVICE_CHECK_PATH"
python "$MODEL_CHECK_PATH"

########################################
#          7. 清理命令提示
########################################

echo "=================================================="
echo " 环境配置完成！后续步骤："
echo " 1. 激活环境："
if [ "$CONDA_INSTALLED" = true ]; then
    echo "    source $CONDA_BASE_DIR/bin/activate $ENV_NAME"
else
    echo "    source $MINICONDA_DIR/bin/activate $ENV_NAME"
fi

# 清理脚本
CLEAN_SCRIPT="$CONDA_EXE deactivate; $CONDA_EXE remove -n $ENV_NAME --all -y"
if [ "$CONDA_INSTALLED" = false ]; then
    CLEAN_SCRIPT="$CLEAN_SCRIPT; rm -rf $WORKSPACE_DIR"
fi

echo " 2. 若不再需要此环境，可以运行以下命令清理："
echo "    $CLEAN_SCRIPT"
echo "=================================================="
