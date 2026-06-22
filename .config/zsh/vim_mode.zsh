# 🎮 Vim 模式
# bindkey -v
# ---------------------------------
# Zsh Vi-mode 与 Fcitx5/大小写同步
# ---------------------------------
# 1. 切换模式时自动切英文
# function zle-keymap-select() {
#     if [[ ${KEYMAP} == vicmd ]]; then
#         (fcitx5-remote -c &)
#     fi
#     zle reset-prompt
# }
# zle -N zle-keymap-select

# 确保 Esc 响应迅速且能触发钩子
# export KEYTIMEOUT=1
# bindkey -M viins '^[' vi-cmd-mode