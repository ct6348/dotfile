#!/usr/bin/env bash
# ──────────────────────────────────────────────
#  wlogout.sh — 电源菜单入口
#  自动检测 compositor（mango / niri / 其他）
#  用法: bash /path/to/wlogout.sh
# ──────────────────────────────────────────────

# 脚本所在目录绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检测 compositor
if [ -n "${NIRI_SOCKET:-}" ]; then
  # niri
  LAYER="${SCRIPT_DIR}/layer/niri"
  PROTO=""
else
  # mango / 其他 Wayland compositor（默认走 layer-shell）
  LAYER="${SCRIPT_DIR}/layer/mango"
  PROTO="--protocol layer-shell"
fi

echo $SCRIPT_DIR
echo $LAYER
exec wlogout -C ${SCRIPT_DIR}/style.css -l "$LAYER" -b 5 $PROTO
