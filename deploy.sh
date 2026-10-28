#!/usr/bin/env bash
set -euo pipefail
# DeepTutor Docker 部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://deeptutor.info
# 更新日期：2026-10-27
# 类型：docker
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "需要先安装 Docker"; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "需要 Docker Compose v2（docker compose 子命令）"; exit 1; }

mkdir -p .download
cd .download

docker run -d --name deeptutor -p 127.0.0.1:3782:3782 -v deeptutor-data:/app/data ghcr.io/hkuds/deeptutor:latest
docker ps --filter name=deeptutor
echo "部署完成：打开 http://127.0.0.1:3782"

echo ""

echo "部署完成：打开 [http://127.0.0.1:3782](http://127.0.0.1:3782)，在 Settings → Providers 里填自己的模型 Key"
echo "若结果异常或需要改配置，请参考官方文档：https://deeptutor.info"
