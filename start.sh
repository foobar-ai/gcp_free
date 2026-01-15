#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

VENV_DIR="${SCRIPT_DIR}/.venv"
INIT_MARKER="${SCRIPT_DIR}/.gcp_free_initialized"

if [[ ! -f "$INIT_MARKER" ]]; then
  if ! command -v gcloud >/dev/null 2>&1; then
    echo "[错误] 未找到 gcloud，请先安装 Google Cloud SDK。" >&2
    exit 1
  fi

  echo "[初始化] 正在启用所需的 GCP API..."
  gcloud services enable cloudresourcemanager.googleapis.com
  gcloud services enable compute.googleapis.com

  if [[ ! -d "$VENV_DIR" ]]; then
    echo "[初始化] 正在创建 venv..."
    python3 -m venv "$VENV_DIR"
  fi

  # shellcheck disable=SC1091
  source "$VENV_DIR/bin/activate"
  python -m pip install google-cloud-compute google-cloud-resource-manager

  touch "$INIT_MARKER"
else
  if [[ ! -d "$VENV_DIR" ]]; then
    echo "[错误] 未找到 venv：$VENV_DIR" >&2
    echo "[错误] 请删除 $INIT_MARKER 以重新初始化。" >&2
    exit 1
  fi
  # shellcheck disable=SC1091
  source "$VENV_DIR/bin/activate"
fi

exec python gcp.py
