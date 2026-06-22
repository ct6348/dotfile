#!/bin/bash

SESSION_NAME="dropdown"
APP_ID="alacritty-dropdown"

if pgrep -f "alacritty.*$APP_ID" >/dev/null; then
  # 获取当前工作区的 id 和 idx
  read -r CURRENT_ID CURRENT_IDX <<<$(niri msg -j workspaces | jq -r '.[] | select(.is_active == true) | "\(.id) \(.idx)"')
  # 获取进程 PID
  PID=$(pgrep -f "alacritty.*$APP_ID" | head -1)
  # 获取窗口 id 和 workspace_id
  read -r WINDOW_ID WINDOW_WORKSPACE_ID <<<$(niri msg -j windows | jq -r ".[] | select(.pid == $PID) | \"\(.id) \(.workspace_id)\"")

  if [ -n "$WINDOW_ID" ] && [ "$WINDOW_ID" != "null" ]; then
    if [ "$WINDOW_WORKSPACE_ID" = "$CURRENT_ID" ]; then
      # 窗口在当前工作区，直接聚焦
      niri msg action focus-window --id "$WINDOW_ID"
    else
      # 窗口在其他工作区，移动至当前工作区（使用 idx）
      niri msg action move-window-to-workspace --window-id "$WINDOW_ID" "$CURRENT_IDX"
    fi
  else
    # 进程存在但窗口未就绪，重启
    pkill -f "alacritty.*$APP_ID"
    sleep 0.5
    alacritty --class "$APP_ID" -e zellij attach --create "$SESSION_NAME" &
  fi
else
  # 进程不存在，启动新窗口
  alacritty --class "$APP_ID" -e zellij attach --create "$SESSION_NAME" &
fi
