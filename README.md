# NLP_QA_ENV

## 项目简介

`NLP_QA_ENV` 是一个用于自然语言处理（NLP）实践的环境配置和测试项目，旨在为不同水平的用户提供一键式的开发环境安装流程。项目包括环境初始化、依赖安装、以及基础功能测试。

通过此项目，用户可以快速配置适用于 RNN、BERT 等模型的实验环境，并支持常见的开源小模型如 Transformers 的集成和运行。

---

## 使用说明

### 环境需求

- 操作系统：
  - Windows 10 或更高版本
  - MacOS
  - 常见的稳定 Linux 发行版
- 硬件要求：推荐 CPU 支持 AVX 指令集，若有 GPU（CUDA 支持），可以启用加速
- 软件依赖：
  - Miniconda (自动下载和安装)
  - Python 3.10 及以上(3.13 以下)

---

### 快速开始

#### 1. 克隆项目

```bash
git clone https://github.com/van-artist/nlp_qa_env.git
cd nlp_qa_env
```

#### 2. 运行主脚本

在 PowerShell 中执行以下命令：

```powershell
.\setup_env.ps1
```

主脚本将依次执行以下操作：

1. 下载并安装 Miniconda。
2. 初始化 Conda 环境并激活。
3. 安装所需依赖。
4. 检查环境是否正确配置。

#### 3. 验证安装

完成后，脚本将自动运行以下验证测试：

- **设备检测**：确认系统是否支持 GPU 加速。
- **RNN 测试**：运行简单的 RNN 测试代码，验证 PyTorch 是否正常。
- **BERT 测试**：验证 Transformers 模型的加载和运行。
- **文本生成测试**：测试开源小模型的集成是否成功。

---

## 项目结构

```plaintext
NLP_QA_ENV/
├── setup_env.ps1          # 主脚本：串联子脚本
├── scripts/               # 子脚本存放目录
│   ├── conda_install.ps1  # Conda 安装脚本
│   ├── env_init.ps1       # 环境初始化脚本
│   ├── env_check.ps1      # 环境检查脚本
│   ├── device_check.py    # 设备检查 Python 脚本
│   ├── model_check.py     # 模型检查 Python 脚本
├── README.md              # 项目文档
```

---

## 注意事项

1. **首次运行脚本后，需重启 PowerShell 以生效 Conda 初始化配置。**
2. 如果安装过程中出现网络问题，可以使用国内镜像（如清华源）加速：

   ```powershell
   $pythonPath -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple torch torchvision transformers
   ```

---

## 联系方式

如有任何问题，请通过以下方式联系我们：

- **邮箱**: shangliu385@gmail.com
- **GitHub Issues**: [点击这里](https://github.com/van-artist/nlp_qa_env/issues)
