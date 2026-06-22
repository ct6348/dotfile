#!/bin/bash

case $1 in
up)
    brightnessctl set +5%
    b=$(brightnessctl get | sed 's/[^0-9]//g')
    m=$(brightnessctl max)
    p=$((b * 100 / m))
    notify-send "亮度: ${p}%" -h int:value:$p -t 1000 --replace-id=555
    ;;
down)
    brightnessctl set 5%-
    b=$(brightnessctl get | sed 's/[^0-9]//g')
    m=$(brightnessctl max)
    p=$((b * 100 / m))
    notify-send "亮度: ${p}%" -h int:value:$p -t 1000 --replace-id=555
    ;;
esac
EOF
