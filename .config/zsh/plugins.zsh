local zinit_home="${HOME}/.local/share/zinit"

# 重新加载 Zsh 以安装 Zinit：
# exec zsh

# 核心扩展
    # zinit-annex-readurl  -> 执行上述命令后，就可以使用 和 ices 以及冰的特殊（附加）能力，支持解析/下载三方网页中的资源。
    # zinit-annex-rust  ->  rust包管理器
    # zinit-annex-patch-dl  ->  您可以使用此功能来下载和应用补丁。例如，要安装 fbterm ，需要两个补丁，一个用于修复操作，另一个用于修复构建：
    # zinit-annex-bin-gem-node  —>  node/python/Ruby  环节变量自动添加，且软件版本自动更新
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-readurl \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

# 命令提示  ->  自动建议，自动完成
# zinit ice wait lucid atload'_zsh_autosuggest_start'
# zinit light zsh-users/zsh-autosuggestions
# zinit ice wait lucid blockf atpull'zinit creinstall -q .'
# zinit light zsh-users/zsh-completions

# 设置自动建议的命令颜色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

# 🚀 性能优化插件（懒加载）
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

# 记录补全耗时（调试完成后移除）
# zmodload zsh/zprof
# compinit() { # zmodload zsh/zprof 的工作机制导致的正常现象（首次加载时记录基线，完整加载后输出最终结果）
#     zprof | head -n 20
#     builtin compinit "$@"
# }

# 历史记录搜索插件，提供多种设置和丰富的主题
# zinit load zdharma-continuum/history-search-multi-word

    # 目录跳转增强 -> 新版插件
    # 提供丰富的命令，比如进入前一个目录；支持多级路径模糊匹配
# zinit ice wait"1" lucid as"program" from"gh-r" \
#     atclone"./zoxide init zsh --cmd z > init.zsh" \
#     atpull"%atclone" src"init.zsh"
# zinit light ajeetdsouza/zoxide

# Git 插件
# zinit ice wait lucid
# zinit snippet OMZ::plugins/git/git.plugin.zsh

# tab 按键补全
zinit light Aloxaf/fzf-tab
# 在 `~/.zshrc` 或 `~/.config/zsh/fzf-tab.zsh` 中调整 `fzf-tab` 行为：
zstyle ":fzf-tab:*" fzf-flags --height=40% --border --reverse --color=bg+:23
zstyle ":fzf-tab:*" fzf-command ftb-tmux-popup  # 或直接用 fzf
# zstyle ":fzf-tab:*" prefix-text "📌 "  # 补全前缀符号

# 命令行 😅表情包 支持
zinit ice wait"1" lucid
zinit light b4b4r07/emoji-cli
# emoji::cli  # 会打开交互式 Emoji 选择界面（使用 fzf）
# echo ":sweat_smile:"  # 输入 :sweat 后按 Tab 会自动补全为
# 🔧 补全系统优化

# 提前加载核心模块
zmodload zsh/parameter zsh/terminfo

# 添加到 ~/.zshrc（必须放在 compinit 之前）
fpath=(${MY_CONFIG_HOME}/zsh/completions $fpath)
# ll 命令补全配置 (ll 是 eza 别名)
# compdef _eza eza ll

autoload -Uz compinit  # 加载 Zsh 的补全系统
# 检查补全缓存，24小时内不重新生成
    # 优化为：只要缓存存在就直接加载（牺牲少量安全性换取速度）z
compinit -C -d "${HOME}/.zcompdump"
# local zcompdump="${HOME}/.zcompdump"
# if [[ -n ${zcompdump}(#qN.mh+24) ]]; then
#     compinit -d "$zcompdump"     # 存在且超过24小时：重新生成补全缓存
# else
#     compinit -C -d "$zcompdump"  # 否则：跳过校验直接加载（加快启动速度）
# fi

# 📣通用补全配置
# m:{a-zA-Z}={A-Za-z} -> 忽略大小写匹配（如输入 "FoO" 可匹配 "foo"）
    # 声明一个匹配器（matcher）
    # 将匹配的字母视为大小写不敏感
# r:|[._-]=* r:|=* - > 允许通过部分前缀匹配（如 "a.b" 匹配 "a_long_b"）
    # r:  ->	声明一个正则扩展匹配器
    # |   ->   分隔符：后面跟用户输入的正则
    # [._-]=* -> 用户输入的 . 或者 _ 或者 - 后面跟任意字符。
    # 可以匹配的内容  *
zstyle ':completion:*' menu select           # 使用菜单交互式选择补全项
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[\._-]=* r:|=*'
# 纯子字符串匹配 → 用 b:= (模糊匹配子串)
    # zstyle ':completion:*' matcher-list \
    # zstyle ':completion:*' matcher-list 'b:='
# 完全禁用智能匹配
    # zstyle ':completion:*' matcher-list ''
    # unsetopt GLOB_COMPLETE

zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'  # 使用 LS_COLORS 的颜色方案
# 自定义补全菜单颜色（示例）

zstyle ':completion:*' rehash true           # 自动重新哈希命令（安装新软件后无需重启）
zstyle ':completion:*' use-cache on          # 启用补全缓存
zstyle ':completion:*' cache-path "${HOME}/.zcompcache"  # 缓存文件路径

zstyle ':completion:*' format '%B%d%b'  # 显示分组标题
zstyle ':completion:*' group-name ''  # 启用分组显示
zstyle ':completion:*:descriptions' format '%F{blue}%B%U%d%u%b%f'  # 彩色标题

# 按需加载重型补全
(( $+commands[npm] )) && zstyle ':completion:*:*:npm:*' tag-order scripts
(( $+commands[systemctl] )) && zstyle ':completion:*:*:systemctl:*' sort false

# zstyle ':completion:*:processes' command 'ps -au$USER'  # 补全时使用ps查看的当前用户的进程列表
zstyle ':completion:*:processes' command 'procs'  # 补全时使用ps查看的当前用户的进程列表
zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b) #([0-9]#)*=01;31=01;31'  # 为 kill 命令的进程 ID 显示红色

# 集成工具初始化（替代 cd 命令）
eval "$(zoxide init zsh)"
