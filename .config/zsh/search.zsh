############################ file and content search #################
# export RG_COMMAND='rg --line-number --color=always --smart-case --hidden --follow --glob "!.git/*"'
#export RG_DEFAULT_COMMAND='/usr/bin/rg --line-number --color=always --smart-case -g "!{backup,.git,code*,JetBrains,mozilla,obsidian,micro,zed}/" -g "!*.{ext1,log}" -g "*.*"'
export RG_DEFAULT_COMMAND='/usr/bin/rg --line-number --color=always --smart-case -g "!{backup,.git}/"'
# -g "*.*"  排除没有后缀的文件

# numbers -> 显示行号
# changes -> 显示 git 变更标记
# export BAT_DEFAULT_COMMAND='bat --color=always --style=numbers,changes --line-range :300' # :300 -> 前300行 | 300/300: -> 从300行开始
export BAT_DEFAULT_COMMAND='bat --color=always --style=plain --line-range :300'

# Cyberpunk (霓虹灯效果)
# local FZF_COLORS_NEON='--color=fg:#00ff99,bg:#0f0f23,hl:#ff00ff,fg+:#00ffff,bg+:#1a1a3a,hl+:#ff9d76,prompt:#ffff00,pointer:#ff2a6d,marker:#f8f8f8,info:#00ffaa,spinner:#ffb86c,header:#6bebff,border:#44475a'

# 颜色主题配置（自定义风格g
# export FZF_COLORS_DEFAULT='--color=fg:#cccccc,bg:#1e1e1e,hl:#569cd6,fg+:#ffffff,bg+:#2d2d2d,hl+:#4ec9b0,info:#b5cea8,prompt:#d7ba7d,pointer:#c586c0,marker:#d7ba7d,spinner:#d7ba7d,header:#569cd6'

# Dark Modern (VS Code 风格)
# export FZF_COLORS_DARK='--color=fg:#abb2bf,bg:#282c34,hl:#61afef,fg+:#ffffff,bg+:#353b45,hl+:#56b6c2,gutter:#282c34,prompt:#e5c07b,pointer:#c678dd,marker:#e06c75,info:#98c379,spinner:#d19a66,header:#61afef,border:#3e4452'

# Light Elegant (Solarized Light)
# export FZF_COLORS_LIGHT='--color=fg:#657b83,bg:#fdf6e3,hl:#268bd2,fg+:#586e75,bg+:#eee8d5,hl+:#2aa198,prompt:#b58900,pointer:#d33682,marker:#dc322f,info:#859900,spinner:#cb4b16,header:#268bd2,border:#93a1a1'

#  Warm Autumn (暖秋色调)
# export FZF_COLORS_WARM='--color=fg:#e0d0b8,bg:#3a3226,hl:#d9822b,fg+:#f8f0e0,bg+:#574832,hl+:#e8b56b,prompt:#d9a662,pointer:#b3804a,marker:#d95749,info:#90b050,spinner:#c78d6a,header:#d9822b,border:#5e4a2d'
# High Contrast (无障碍模式)
# export FZF_COLORS_ACCESSIBLE='--color=fg:#000000,bg:#ffffff,hl:#ff0000,fg+:#ffffff,bg+:#0000dd,hl+:#ffff00,prompt:#00aa00,pointer:#ff00ff,marker:#ff8800,info:#0000ff,spinner:#00ffff,header:#888888,border:#cccccc'

# FZF 默认设置
# 核心命令定义 follow -> 跟随符号链接
# export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --ignore-file ${MY_CONFIG_HOME}/ini/.fdignore"
export FZF_DEFAULT_COMMAND='fd -E "node_modules" -E "target" -E "out" -E "dist" -E "build" -E "*.log"'
# --bind 'tab:down' → Tab 向下移动
# --bind 'btab:up' → Shift+Tab 向上移动
# export FZF_DEFAULT_OPTS="
#             --ansi $FZF_COLORS_NEON
#             --preview \"$BAT_DEFAULT_COMMAND {1}\"
#             --bind tab:down,btab:up
#             --height=90% --layout=reverse
#             --border=rounded --cycle
#             --bind 'enter:execute(if [[ -f {1} && ! {1} =~ : ]]; then nvim {1}; fi)'
#             --bind=ctrl-d:abort
#             --bind 'ctrl-j:preview-down,ctrl-k:preview-up'
#             --preview-window \"up:60%:wrap\"  # 确保启用自动换行"
#             --bind 'enter:execute(if [[ -f {1} && ! {1} =~ : ]]; then nvim {1}; fi)'
# export FZF_DEFAULT_OPTS="
#             --ansi $FZF_COLORS_NEON
#             --preview \"$BAT_DEFAULT_COMMAND {1}\"
#             --bind tab:down,btab:up
#             --height=90% --layout=reverse
#             --border=rounded --cycle
#             --bind=ctrl-d:abort
#             --bind 'ctrl-j:preview-down,ctrl-k:preview-up'
#             --preview-window \"up:60%:wrap\"  # 确保启用自动换行"
#             --bind 'enter:execute(if [[ -f {1} && ! {1} =~ : ]]; then nvim {1}; fi)'
# export FD_PREFIX="fd --ignore-file ${MY_CONFIG_HOME}/ini/.fdignore"
# alias fd=$FD_PREFIX
# export RG_PREFIX='rg --line-number --color=always --smart-case'
# alias rg=$RG_PREFIX


#-----------------------------------------
# 文件搜索
#-----------------------------------------
__ffd() {
    local query="$*"
    # 使用 FZF 选择文件并用 Neovim 打开
    local selected_files=$(eval $FZF_DEFAULT_COMMAND | fzf \
        --multi \
        --query="$query" \
        --prompt="📝 选择文件编辑 > " \
        --preview="$BAT_DEFAULT_COMMAND {}" \
        --preview-window="up,70%,border-bottom" \
        --header="TAB: 多选 | ENTER: 打开 | ESC: 取消")

    if [[ -n "$selected_files" ]]; then
        echo "📝 用 Neovim 打开: $selected_files"
        nvim $selected_files
    fi
}

#-----------------------------------------
# 内容搜索
#-----------------------------------------
__frg() {
    local rg_query="$*"
    local search_mode="file" # file|content

    # ripgrep 命令
    local rg_file="${FZF_DEFAULT_COMMAND}"
    echo ${FZF_DEFAULT_COMMAND}
    local rg_content='rg --line-number --color=always --smart-case --no-heading'

    # 构建预览命令，{1} -> 第一个参数
    local preview_cmd="bat --color=always --style=plain"

    local FZF_COLORS_NEON='--color=fg:#00ff99,bg:#0f0f23,hl:#ff00ff,fg+:#00ffff,bg+:#1a1a3a,hl+:#ff9d76,prompt:#ffff00,pointer:#ff2a6d,marker:#f8f8f8,info:#00ffaa,spinner:#ffb86c,header:#6bebff,border:#44475a'

    FZF_DEFAULT_COMMAND="$rg_file" \
        fzf --ansi \
        --query "$rg_query" \
        --height=80% \
        --layout=reverse \
        --border=rounded \
        ${FZF_COLORS_NEON} \
        --bind "ctrl-f:reload($rg_file)+change-prompt( 文件搜索 > )+change-preview($preview_cmd --line-range :300 {1})+change-preview-window(hidden)" \
        --bind "ctrl-g:reload($rg_content {q} || true)+change-prompt( 内容搜索 > )+change-preview($preview_cmd --highlight-line {2} {1} )+change-preview-window(up,70%,wrap,+{2}+3/2)" \
        --bind "ctrl-y:execute(echo -n {1} | xclip -selection clipboard)+abort" \
        --bind "ctrl-/:toggle-preview" \
        --bind "change:reload(if [[ $search_mode == file ]]; then $rg_file {q}; else $rg_content {q}; fi || true)" \
        --bind "enter:execute(if [[ -f {1} && ! {1} =~ : ]]; then nvim {1}; fi)" \
        --bind=ctrl-d:abort \
        --bind 'ctrl-j:preview-down,ctrl-k:preview-up' \
        --preview "$preview_cmd --line-range :300 {1}" \
        --preview-window "hidden,up,70%,wrap" \
        --delimiter=":" \
        --with-nth="1,3.." \
        --header=$'CTRL-F: 文件搜索 | CTRL-G: 内容搜索 | ENTER: 打开文件 | CTRL-up: CTRL-/: 预览开关 | 向上预览 | CTRL-down: 向下预览 | CTRL-Y: 复制路径 | ESC: 退出' \
        --prompt="  文件搜索 > " \
        --pointer="➤ " \
        --marker="✓ "
}

#----------------------------------------
# search file and content
#----------------------------------------
alias ffd="__ffd" frg="__frg"
alias grep='grep --color=auto' fgrep='fgrep --color=auto' egrep='egrep --color=auto'
alias fdsys='/usr/bin/fd --base-directory / --ignore-file ${MY_CONFIG_HOME}/ini/.fdignoreSys --type f' # 过滤系统目录 & 查询文件
# fdsys() {
#     /usr/bin/fd --ignore-file "${MY_CONFIG_HOME}/ini/.fdignoreSys" --type f -H "$@" /
# }
alias fdhm='/usr/bin/fd --base-directory $HOME --ignore-file ${MY_CONFIG_HOME}/ini/.fdignoreHome --type f -H'     # 过滤系统目录 & 查询文件
alias fddata='/usr/bin/fd --base-directory /data/main --ignore-file ${MY_CONFIG_HOME}/ini/.fdignoreData --type f' # 过滤系统目录 & 查询文件

alias fdd="$FZF_DEFAULT_COMMAND --type d" # 查询文件
alias fdf="$FZF_DEFAULT_COMMAND --type f" # 查询文件
alias rgg='/usr/bin/rg --line-number --color=always --smart-case -g "!{backup,.git,code*,JetBrains,mozilla,obsidian,micro,zed}/" -g "!*.{ext1,log}" -g "*.*"' # 查询内容