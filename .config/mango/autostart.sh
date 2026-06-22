#!/bin/bash
set +e

# =================== 无复杂 waybar ，无自动熄屏，锁屏
# 壁纸（用作者带的壁纸，或随便一张）
swaybg -i ~/.config/wallpaper/wallpaper.png >/dev/null 2>&1 &

# 顶栏
waybar -c ~/.config/waybar-themes/simple/config.jsonc -s ~/.config/waybar-themes/simple/style.css >/dev/null 2>&1 &

# 🎯 VNC 远程桌面（只监听本地）
# wayvnc 127.0.0.1 5902 >/dev/null 2>&1 &

# xwayland dpi
echo "Xft.dpi: 96" | xrdb -merge

# fcitx5 输入法（可选，如果需要中文输入）
fcitx5 --replace -d >/dev/null 2>&1 &
