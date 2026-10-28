#!/bin/bash
set -euo pipefail
APP_DIR="$(dirname "$0")"
APP_DIR="$(realpath "$APP_DIR")"
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This app requires macOS."
  exit 1
fi
if ! command -v python3 >/dev/null 2>&1; then
  echo "Install Python 3.9 or newer first: https://www.python.org/downloads/macos/"
  exit 1
fi
if [[ ! -x "$APP_DIR/.venv/bin/python" ]]; then
  python3 -m venv "$APP_DIR/.venv"
fi
if ! "$APP_DIR/.venv/bin/python" -c 'import Quartz, AppKit' >/dev/null 2>&1; then
  "$APP_DIR/.venv/bin/python" -m pip install -r "$APP_DIR/requirements.txt"
fi
exec "$APP_DIR/.venv/bin/python" "$APP_DIR/auto_key_web.py"
