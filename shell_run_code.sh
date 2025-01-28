#!/usr/bin/env bash
#
# 一键运行 src/main.py 脚本
# 特点：
# 1. 若系统有 conda，则使用系统 conda
# 2. 若系统无 conda，则在当前目录安装 miniconda
# 3. 在 minimal_env 环境中运行 main.py
# 4. 不修改用户 HOME，不污染系统 Python

# 遇到错误即退出
set -e

########################################
#             1. 目录定义
########################################

WORKSPACE_DIR="$(pwd)"       # 当前工作目录
SRC_DIR="$WORKSPACE_DIR/src" # 源码目录
MAIN_PATH="$SRC_DIR/main.py" # main.py 路径

# 建议将 Miniconda 安装在当前目录下
MINICONDA_DIR="$WORKSPACE_DIR/miniconda"
ENV_NAME="nlp_course_env"

echo "=================================================="
echo " 一键运行 src/main.py"
echo "=================================================="

########################################
#          2. 检测 Conda
########################################

if command -v conda &>/dev/null; then
    echo "=> 检测到系统已安装 Conda."
    CONDA_INSTALLED=true
    # 系统 Conda 的基路径
    CONDA_BASE_DIR="$(conda info --base)"
else
    echo "=> 系统未检测到 Conda，准备在本地安装 Miniconda..."
    # 下载并在当前目录安装
    curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh \
        -o "$WORKSPACE_DIR/miniconda_installer.sh"
    bash "$WORKSPACE_DIR/miniconda_installer.sh" -b -p "$MINICONDA_DIR"
    # 配置脚本内环境变量
    export PATH="$MINICONDA_DIR/bin:$PATH"
    CONDA_INSTALLED=false
    CONDA_BASE_DIR="$MINICONDA_DIR"
fi

CONDA_EXE="$CONDA_BASE_DIR/bin/conda"

########################################
#          3. 创建/激活环境
########################################

# 检查目标环境是否存在
ENV_EXISTS=$($CONDA_EXE info --envs | awk '{print $1}' | grep -x "$ENV_NAME" || echo "")

if [ -n "$ENV_EXISTS" ]; then
    echo "=> 环境 '$ENV_NAME' 已存在，将直接使用。"
else
    echo "=> 创建新环境 '$ENV_NAME'..."
    $CONDA_EXE create -n "$ENV_NAME" python=3.9 -y
fi

# 激活环境
if [ "$CONDA_INSTALLED" = true ]; then
    # 系统已安装 conda
    source "$CONDA_BASE_DIR/bin/activate" "$ENV_NAME"
else
    # 使用本地 Miniconda
    source "$MINICONDA_DIR/bin/activate" "$ENV_NAME"
fi

########################################
#          4. 安装/升级依赖 (可选)
########################################
# 如果 src/main.py 中需要特定 Python 包，可以在此处安装。
# 例如：
# pip install --upgrade pip
# pip install requests pandas ...

########################################
#          5. 运行 main.py
########################################

if [ ! -f "$MAIN_PATH" ]; then
    echo "错误：未找到 $MAIN_PATH 文件，请检查路径或脚本。"
    exit 1
fi

echo "=> 开始运行: $MAIN_PATH"
python "$MAIN_PATH"

########################################
#          6. 显示结束信息
########################################

echo "=================================================="
echo "运行完成！"
echo "当前环境：$ENV_NAME"
if [ "$CONDA_INSTALLED" = true ]; then
    echo "如需退出环境，可执行: conda deactivate"
else
    echo "如需退出环境，可执行: source $MINICONDA_DIR/bin/deactivate"
fi

# 清理命令示例（可选）
CLEAN_SCRIPT="$CONDA_EXE deactivate; $CONDA_EXE remove -n $ENV_NAME --all -y"
if [ "$CONDA_INSTALLED" = false ]; then
    CLEAN_SCRIPT="$CLEAN_SCRIPT; rm -rf $MINICONDA_DIR; rm -f $WORKSPACE_DIR/miniconda_installer.sh"
fi

echo "如需完全清理当前环境，可执行："
echo "$CLEAN_SCRIPT"
echo "=================================================="
