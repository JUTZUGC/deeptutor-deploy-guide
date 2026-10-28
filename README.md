# DeepTutor Docker 部署指南

> 第三方部署指南 · 非 DeepTutor 官方仓库。官方项目：[HKUDS/DeepTutor](https://github.com/HKUDS/DeepTutor)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://deeptutor.info)为准。

[![⚡ Docker 部署](https://img.shields.io/badge/%E2%9A%A1_Docker_%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#docker部署推荐用百度搭子)

## Docker 部署（推荐：用百度搭子）

> [!TIP]
> 想要一个能讲题、出卷、还能画图的学习搭子？让百度搭子把 DeepTutor 跑起来。

⚠️ 需要 Docker。默认不含任何模型 Key，必须自己配一个提供商（OpenAI 兼容接口、Ollama 等）。知识库与 RAG 相关能力还会额外占用内存和磁盘。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/deeptutor-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子用官方镜像起一个容器，映射 3782 端口并挂载数据卷，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Docker；未安装时按对话提示安装。）



## DeepTutor 是什么？

DeepTutor 是开源的46.3k stars，Apache-2.0，HKUDS 出品的个性化学习工作台，讲题、出卷、研究、可视化一站搞定（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/HKUDS/DeepTutor?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

一个 Agent 原生的学习工作台：把答疑、出题、研究、可视化、精读、课程学习和掌握度训练放进同一个运行时，共享知识库、教材和记忆。

- 46.3k stars：2025-12 建仓，不到一年冲到 4.6 万
- 一种运行时十种模式：答疑、出题、研究、可视化、解题、精读、音频概览
- 知识库多引擎：LlamaIndex、PageIndex、GraphRAG、LightRAG 都能接
- 视频学习：YouTube / Bilibili 链接直接播放，字幕搜索与时间戳定位
- 可检查的记忆：L1 轨迹、L2 摘要、L3 综合，记忆图谱可编辑
- 一条 Docker 命令就能试，不用装 Python 和 Node

（来源：[官方仓库](https://github.com/HKUDS/DeepTutor)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 46.3k stars | 2025-12 建仓，不到一年 4.6 万 |
| 模式齐全 | 答疑、出题、研究、可视化都在一处 |
| 知识库多引擎 | GraphRAG / LightRAG / PageIndex 都能接 |
| Docker 一条命令 | 不用装 Python 和 Node |
| 记忆可编辑 | 三层记忆加记忆图谱 |
| 中文支持 | 多语言 README 与界面 |

| 需要注意 | 说明 |
|---|---|
| 必须自配模型 | 不带 Key 就是空壳 |
| 镜像体积大 | 首次拉取耗时 |
| RAG 吃资源 | 知识库引擎占内存和磁盘 |
| 功能面很宽 | 新手容易不知道从哪开始 |
| 部分能力依赖外部 CLI | 如 MinerU、LaTeX、ffmpeg |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 快速部署（官方方式）

```bash
docker run -d --name deeptutor -p 127.0.0.1:3782:3782 -v deeptutor-data:/app/data ghcr.io/hkuds/deeptutor:latest
docker ps --filter name=deeptutor
echo "部署完成：打开 http://127.0.0.1:3782"
```

部署步骤来源：[https://github.com/HKUDS/DeepTutor#one-command-docker-trial](https://github.com/HKUDS/DeepTutor#one-command-docker-trial)

## 验证状态

| 场景 | 状态 |
|---|---|
| 仓库元数据核对：46,341 stars、5,795 forks、Apache-2.0、2025-12-28 建仓 | 已核对 2026-10-27 |
| GitHub Trending 日榜 +1598 | 已核对 2026-10-27 |
| README 确认 Docker 试跑命令与镜像地址 ghcr.io/hkuds/deeptutor:latest | 已核对 2026-10-27 |
| README 确认端口 3782、数据目录 /app/data、最新 release v1.6.15 | 已核对 2026-10-27 |
| README 确认 PyPI 包名 deeptutor，要求 Python 3.11–3.14 与 Node 20+ | 已核对 2026-10-27 |
| 未实测 Docker 启动与模型调用（本机未安装 Docker） | 说明 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

DeepTutor 支持接入外部 MCP server 作为工具扩展，但它本身不是 MCP server；本仓库只负责部署，不注册 MCP。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\deeptutor-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 部署完成后

### 1. 配模型

打开 [http://127.0.0.1:3782](http://127.0.0.1:3782)，进 **Settings → Providers**，填自己的提供商。支持 Anthropic、OpenAI、Gemini、任意 OpenAI 兼容接口，也能接 Ollama 跑本地模型。

### 2. 数据存在哪

镜像把数据写在容器内 `/app/data`，部署时挂到了命名卷 `deeptutor-data`。想换成宿主目录：

```bash
docker run -d --name deeptutor -p 127.0.0.1:3782:3782 -v /你的路径:/app/data ghcr.io/hkuds/deeptutor:latest
```

### 3. 十种模式

| 模式 | 干什么 |
|---|---|
| Chat | 日常答疑 |
| Ask Questions | 针对材料追问 |
| Quiz | 自动出题 |
| Research | 多源检索后成稿 |
| Visualize | 把概念画成图 |
| Solve | 分步解题 |
| Course Study | 按课程推进 |
| Mastery Path | 掌握度训练 |
| Immersive Reading | 精读材料 |
| Audio Overview | 生成音频概览 |

### 其它安装方式

| 方式 | 适合 |
|---|---|
| `pip install -U deeptutor` | 本地 Web + CLI，需要 Python 3.11–3.14 与 Node 20+ |
| 源码安装 | 要改代码，Node 22 LTS |
| Agent 代装 | 让 AI 读 `SKILL.md` 和 `docs-for-user/AGENT_SETUP.md` 自动装 |

### 常用命令

```bash
deeptutor init      # 配端口与提供商
deeptutor start     # 起前后端
deeptutor workspace show
```

> ⚠️ 工作区之外的执行是只读的，生成文件放在 `outputs/<能力>/<会话>/<轮次>/`；要复制到别处需要你在界面上点一次「Allow once」。

## 常见坑

- 端口冲突：把 `-p 127.0.0.1:3782:3782` 左边改成别的端口
- 打开是白屏：先 `docker logs deeptutor` 看后端起没起来
- 模型报 401：Base URL 与 Key 不匹配，注意是否要带 `/v1`
- 上传 PDF 解析失败：本地解析需要额外装 MinerU，或改用云端解析
- 语音转写失败：原生 STT 适配器需要 `ffmpeg` 在 PATH 里
- 升级丢数据：命名卷 `deeptutor-data` 不随容器删除，别手动 `docker volume rm`

## 免责声明

本仓库为第三方指南，与 DeepTutor 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://deeptutor.info)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
