#!/bin/bash

WORKSPACE="2:ext"
OUTPUT="DP-1" # 你的大显示器名称

# 获取当前聚焦的窗口
FOCUSED_WINDOW=$(niri msg -j focused-window)

# 判断是否是浏览器（可选）
APP_ID=$(echo "$FOCUSED_WINDOW | jq -r .app_id")

# 如果窗口支持假全屏，则启用
if [[ "$APP_ID" == "firefox" ]] || [[ "$APP_ID" == "chromium" ]]; then
  niri msg action toggle-windowed-fullscreen
  # 等待一小会儿让窗口获得焦点
  sleep 0.1
fi

# 移动窗口到演示工作区
niri msg action move-column-to-workspace "$WORKSPACE"

# 可选：也把工作区移动到指定显示器
niri msg action move-workspace-to-monitor-previous "$WORKSPACE"

# 切换到演示工作区
niri msg action focus-workspace "$WORKSPACE"

# 可选：全屏显示（如果需要）
# niri msg action toggle-fullscreen-window

# 使用 niri msg 发送多个命令
# niri msg action toggle-windowed-fullscreen
# niri msg action move-column-to-workspace "2:ext"
# niri msg action focus-workspace "2:ext"
