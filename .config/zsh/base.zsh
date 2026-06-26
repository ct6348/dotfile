#-----------------------------------------
# 基础
#-----------------------------------------
alias ls='eza --color=auto --icons --git' l='ls -lhg --time-style=long-iso' ll='l -a' lt='l -T'
alias cd='z' ..='cd ..' ...='cd ../..' ....='cd ../../..' ~='cd ~'
alias dbox='distrobox'
alias md='mkdir -p' rd='rmdir' cls='clear'
alias pacman='sudo pacman'
alias nv='nvim' nvs="sudo nvim"
# 不加载 init 文件，但插件/脚本等还是会加载
alias vi='nvim -u NONE'
# 🔥 最接近 vi 纯净模式 — 不加载任何 init.lua、不加载插件、不加载 shada（历史记录）、使用全部默认设置
alias vnp='nvim --clean'
# 不加载系统/用户 init 文件，但仍可能加载某些自动加载的脚本
# alias vim='nvim -u NORC'
# alias top='btop'
alias zl="/usr/bin/zellij"
alias t8="cd /data/containers/lxcData/ai/claude-code-t8 && bun run desktop"
alias cdincusdata="cd /var/lib/incus/pools/custom/default_data-vol"
alias grootpwd="rpass --show local/root -c"
alias printenv='print -l "${(s/:/)PATH}"'

# alias x='/usr/bin/x-cmd'
# alias yz="/usr/bin/yazi"
# alias idea='${HOME}/data/JetBrains/idea-2025/bin/idea'
