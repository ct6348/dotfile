#!/bin/bash
# mango-window-switcher.sh — 带 tags 显示的窗口切换器

selected=$(mmsg get all-clients | jq -r '
  .clients[] | [
    .id,
    (.title[0:10] + (if (.title | length) > 10 then "…" else "" end)),
    (.appid[0:20] + (if (.appid | length) > 10 then "…" else "" end)),
    (.tags | join(",")),
    .monitor,
    (if .is_focused then "★" else " " end)
  ] | @tsv
' | column -t -s $'\t' | fuzzel --dmenu --prompt="Window> ")

if [ -n "$selected" ]; then
  id=$(echo "$selected" | awk '{print $1}')
  mmsg dispatch focusid client,"$id"
fi
