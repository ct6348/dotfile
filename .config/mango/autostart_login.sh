#!/bin/bash

#################################################
# 登录时加载，只加载一次
#################################################

set +e

# 壁纸
swaybg -i ~/.config/wallpaper/1363709.png >/dev/null 2>&1 &

# 顶栏
waybar -c ~/.config/waybar-themes/catppuccin/config.jsonc -s ~/.config/waybar-themes/catppuccin/style.css >/dev/null 2>&1 &

# 省电脚本（锁屏，熄屏）
bash ~/.config/mango/scripts/idle.sh
# VNC 远程（依然保留）
# wayvnc 127.0.0.1 5902 >/dev/null 2>&1 &

# 通知后台
mako >/dev/null 2>&1 &

# vicinae 启动器服务
# vicinae server >/dev/null 2>&1 &
vicinae server >>~/.local/share/vicinae/vicinae.log 2>&1 &

# 剪贴板持久化 + 历史 （已经用 vicinae 代替）
# 默认 Wayland 下，复制内容后关闭来源程序（如关闭终端），剪贴板内容就丢了。
# 下面这个命令利用 wl-clip-persist 这个命令让剪贴板内容一直保留，直到你复制新的内容覆盖它
# wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &
# --type text 只存文本
# wl-paste --watch cliphist store >/dev/null 2>&1 &
# wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# 提权对话框（用 polkit-gnome 替代 xfce-polkit）
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null 2>&1 &

# xwayland dpi
echo "Xft.dpi: 96" | xrdb -merge

# 输入法（如有需要）
fcitx5 --replace -d >/dev/null 2>&1 &
