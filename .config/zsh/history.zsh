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
    local cmd=${line%%[[:space:]]*}

    # 纯命令名排除（case 比正则轻量，无编译开销）
    case "$cmd" in
        l|ll|z|cd|nv|vi|vii|vim|pwd|hfs|rm|mv|cp|cat|bat|dust|fzf|ls|cls|exit)
            return 1 ;;
    esac

    # 带特定参数：只排除 pacman/paru -Ss（搜索），保留 -S 安装等操作
    [[ "$cmd" == "pacman" && "$line" == *[[:space:]]-[SQ]s* ]] && return 1
    [[ "$cmd" == "paru"   && "$line" == *[[:space:]]-[SQ]s* ]] && return 1

    return 0
}

__fhs() {
    local selected cmd
    local -i limit=${1:-500}

    selected=$(fc -lir -$limit | fzf \
        --height=40% \
        --tiebreak=index \
        --header='CTRL-/: 预览, Enter: 选择' \
        --preview='echo {}' \
        --preview-window='up:2:wrap' \
        --no-sort)

    if [[ -n "$selected" ]]; then
        echo "------------"
        cmd="${selected##<-> }"
        cmd="${cmd#* }"
        cmd="${cmd#* }"
        cmd="${cmd#* }"

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
