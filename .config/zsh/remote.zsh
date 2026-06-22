# 远程桌面连接函数
function __rdp-win() {
  noglob sdl-freerdp3 \
    "/v:${1:-192.168.3.140}" \
    "/u:${2:-LiuuiL}" \
    +clipboard \
    "/drive:share,${3:-/data/main/projectfile/projectpak/}" \
    "/kbd:layout:0x00000809,lang:0x0809" \
    /gfx:AVC420 \
    +dynamic-resolution
}
# 快捷别名（默认参数）
alias rdp='__rdp-win'
