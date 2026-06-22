#!/usr/bin/bash

pkill swayidle

# 空闲锁屏（120s调暗 -> 5分钟锁屏 -> 10分钟息屏）
swayidle \
  timeout 120 'dimland -a 0.6' resume 'pkill dimland' \
  timeout 300 'swaylock -f -c 000000' \
  timeout 600 'wlr-dpms off' resume 'wlr-dpms on && bash ~/.config/mango/scripts/restart_wlsunset.sh' \
  before-sleep 'swaylock -f -c 000000' \
  >/dev/null 2>&1 &

# wlr-dpms状态 	 效果	功耗	恢复速度
# Standby（待机）	屏幕黑，但电路还在工作	❄️ 低	⚡ 快（1 秒）
# Suspend（暂停）	屏幕黑，大部分电路关闭	❄️❄️ 更低	⚡ 较慢（2-3 秒）
# Off（关闭）	显示器彻底断电信号，进入最深度休眠（服务正常运行）
