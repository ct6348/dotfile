#!/usr/bin/bash

set +e

pkill wlsunset
nohup wlsunset -T 6000 -t 4000 >>/dev/null 2>&1 &

# A	6500K 日光白	4000K 暖黄	成都经纬度	✅ 日常办公
# B	5500K 中性白	4000K 暖黄	成都经纬度	嫌 6500K 太冷
# C	4000K	4000K	固定值	全天护眼
# D（默认）	6500K	4000K	固定时间 06:00/18:00	不想用地理位置
# k --- 开尔文 单位，命令中不需要
