#!/bin/bash

case $1 in
up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
    v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')
    notify-send "音量: ${v}%" -h int:value:$v -t 1000 --replace-id=555
    ;;
down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
    v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')
    notify-send "音量: ${v}%" -h int:value:$v -t 1000 --replace-id=555
    ;;
mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)
    if [ "$muted" -eq 1 ]; then
        notify-send "音量: 已静音" -t 1000 --replace-id=555
    else
        v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')
        notify-send "音量: ${v}%" -h int:value:$v -t 1000 --replace-id=555
    fi
    ;;
esac
