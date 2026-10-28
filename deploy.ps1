# DeepTutor Docker 部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://deeptutor.info
# 更新日期：2026-10-27
# 类型：docker
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

foreach ($cmd in @('git', 'docker')) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) { throw "需要先安装 $cmd" }
}
docker compose version | Out-Null
if ($LASTEXITCODE -ne 0) { throw '需要 Docker Compose v2（docker compose 子命令）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

docker run -d --name deeptutor -p 127.0.0.1:3782:3782 -v deeptutor-data:/app/data ghcr.io/hkuds/deeptutor:latest
docker ps --filter name=deeptutor
Write-Host '部署完成：打开 http://127.0.0.1:3782'

Write-Host ''

Write-Host '部署完成：打开 [http://127.0.0.1:3782](http://127.0.0.1:3782)，在 Settings → Providers 里填自己的模型 Key'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://deeptutor.info'
