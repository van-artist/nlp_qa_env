# NLP_QA_ENV

## 项目简介

`NLP_QA_ENV` 是一个面向自然语言处理（NLP）实践的一键式环境配置项目，专为**不熟悉环境配置的初学者**设计，同时提供**手动模式**供有经验的开发者使用。项目提供：

- **全自动环境初始化**：无需手动安装任何依赖，适合初学者快速上手。
- **手动快速配置流程**：为熟悉 Conda 的用户提供灵活的操作方式。
- **硬件加速自动检测**：自动检测 CPU/GPU 支持情况，确保最佳性能。
- **主流模型运行验证**：支持 RNN、BERT 等模型的快速验证，确保环境可用。

---

## 使用说明

### 环境需求

- **操作系统**：
  - Windows 10+（推荐使用 Git Bash 或 WSL）
  - MacOS
  - Linux（常见发行版如 Ubuntu、CentOS 等）

---

## 快速开始

### 自动配置流程（推荐新手）

1. **克隆项目**：

   ```bash
   git clone https://github.com/van-artist/nlp_qa_env.git
   cd nlp_qa_env
   ```

2. **运行自动化脚本**：

   ```bash
   # 赋予脚本执行权限（Linux/MacOS）
   chmod +x setup_env.sh

   # 启动全自动配置
   ./setup_env.sh
   ```

3. **根据提示操作**：

   - 脚本将自动完成：
     - Miniconda 静默安装（约 500MB）
     - 创建名为 `nlp_env` 的隔离环境
     - 安装 PyTorch/Transformers 等依赖
     - 运行硬件检测和模型验证

4. **环境生效**：
   - 脚本结束后，输入以下命令激活环境：
   ```bash
   conda activate nlp_env
   ```
   - 或者直接双击执行`run_code.bat`脚本，这可以自动执行`src/`目录下的`main.py`文件，你可以在 src 内自由编辑你的项目

---

### 手动配置流程（熟悉 Conda 用户）

1. **创建并激活环境**：

   ```bash
   conda create -n nlp_env python=3.10 -y
   conda activate nlp_env
   ```

2. **安装核心依赖**：

   ```bash
   # 使用官方源
   pip install torch torchvision transformers

   # 或使用国内镜像加速
   pip install -i https://pypi.tuna.tsinghua.edu.cn/simple \
     torch torchvision transformers
   ```

3. **验证安装**：

   ```bash
   # 运行设备检测
   python scripts/device_check.py

   # 运行BERT测试
   python scripts/model_check.py --model bert
   ```

---

## 注意事项

1. **首次运行脚本后，需重启终端以生效 Conda 初始化配置。**
2. 如果安装过程中出现网络问题，可以使用国内镜像（如清华源）加速：

   ```bash
   pip install -i https://pypi.tuna.tsinghua.edu.cn/simple torch torchvision transformers
   ```

---

## 联系方式

如有任何问题，请通过以下方式联系我们：

- **邮箱**: shangliu385@gmail.com
- **GitHub Issues**: [点击这里](https://github.com/van-artist/nlp_qa_env/issues)

---

> **提示**：本文档同时提供 [PDF 版本](./docs/User_Manual.pdf) 供离线使用。

---

### 额外说明

- **默认使用 CPU 平台**：本项目默认配置为 CPU 模式，以确保最大兼容性。如果您的设备支持 GPU 加速，可以参考项目中的高级配置指南手动启用。
- **跨平台支持**：Shell 脚本兼容 Linux、MacOS 和 Windows（通过 Git Bash 或 WSL），确保用户在不同操作系统下都能顺利使用。
- **灵活性**：无论是初学者还是高级用户，都能通过本项目快速搭建 NLP 实验环境，专注于模型开发和实践。
