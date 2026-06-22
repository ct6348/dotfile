# setopt SHARE_HISTORY
# 1. SHARE_HISTORY 会导致你在一个终端输入的命令，瞬间“污染”到另一个正在输入的终端（如果你按上下键），有些人会觉得很难用
# 2. SHARE_HISTORY 其实已经包含了 INC_APPEND_HISTORY 的功能
# 如果不想被污染，可以修改 setopt SHARE_HISTORY  --> setopt APPEND_HISTORY INC_APPEND_HISTORY

# 变量设置
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=20000
export SAVEHIST=25000

# 基础性能优化
setopt BANG_HIST                 # 兼容脚本中的 ! 命令
setopt EXTENDED_HISTORY          # 记录命令执行时间 (给 fc -i 使用)

# 写入与同步
setopt APPEND_HISTORY            # 以追加方式写入记录
setopt INC_APPEND_HISTORY        # 命令执行完立刻存盘
# setopt SHARE_HISTORY           # 根据个人喜好选择是否开启（开启后命令实时跨窗口同步）

# 强力排重 (这对 fzf 搜索非常重要)
setopt HIST_IGNORE_ALL_DUPS      # 删除旧的重复命令，只保留最新的
setopt HIST_EXPIRE_DUPS_FIRST    # 当历史存满时，先删除重复的
setopt HIST_IGNORE_SPACE         # 以空格开头的命令不记入历史（保护敏感密码）
setopt HIST_REDUCE_BLANKS        # 删除多余空格
setopt HIST_SAVE_NO_DUPS         # 存盘时不存重复的
setopt HIST_FIND_NO_DUPS         # 搜索时不显示重复的

setopt HIST_VERIFY               # 使用 ! 执行历史命令前先预览，不直接运行

# 优化后的历史命令过滤钩子
zshaddhistory() {
    local line=${1%%$'\n'}
    # 使用单词边界匹配，避免误删 zinit 等命令
    [[ $line =~ "^(ll|l|z|cd|cls|exit|vi|vim|vii)([[:space:]]|$)" ]] && return 1
    # [[ $line =~ "(password|token|key|secret)" ]] && return 1
    return 0
}

# --preview-window='hidden,up:2:wrap' \

__fhs() {
    local selected cmd
    # 修复 1: 范围从 1 开始
    # 修复 2: 使用 fzf 的 --with-nth 实现更好的视觉显示和数据提取平衡
    # selected=$(fc -Dlir 1 | fzf \
    #     --height=40% \
    #     --tiebreak=index \
    #     --header='CTRL-/: 预览, Enter: 选择' \
    #     --bind "ctrl-/:toggle-preview" \
    #     --preview='echo {}' \
    #     --preview-window='up:2:wrap' \
    #     --no-sort)

    selected=$(fc -Dlir 1 | fzf \
        --height=40% \
        --tiebreak=index \
        --header='CTRL-/: 预览, Enter: 选择' \
        --preview='echo {}' \
        --preview-window='up:2:wrap' \
        --no-sort)

    if [[ -n "$selected" ]]; then
        echo "------------"
        # 修复 3: 使用更健壮的正则删除前缀（匹配索引、时长、日期、时间）
        # 这里的 [0-9: \-]+ 匹配类似 "1234  0:00  2026-02-03 03:00  " 的前缀
        cmd=$(echo "$selected" | sed -E 's/^[ ]*[0-9]+[ ]+[^ ]+[ ]+[^ ]+[ ]+[^ ]+[ ]+//')

        if [[ -n $WIDGET ]]; then
            LBUFFER="$cmd"
            CURSOR=$#LBUFFER
            zle redisplay
        else
            print -z "$cmd"
        fi
    fi
}


# 注册为 zle widget
# zle -N __fhs

# 绑定快捷键 (可选)
# bindkey '^R' __fhs

alias fhs='__fhs'
