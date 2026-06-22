######################## 🎨 主题管理 ##############################

__init_theme() {
    local theme="${1:-pure}"

    case "$theme" in
        starship)
            ZSH_THEME="starship"
            # zinit ice as"command" from"gh-r" \ # as "command" 添加到 PATH 中
            zinit ice from"gh-r" \
                atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
                atpull"%atclone" src"init.zsh"
            zinit light starship/starship
            ;;
        pure)
            zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
            zinit light sindresorhus/pure
            # autoload -U promptinit; promptinit  # 打印命令提示
            # zstyle :prompt:pure:path color '#fb5ff8'    # 改变路径颜色
            # zstyle :prompt:pure:git:stash show true
            # prompt pure
            ;;
        robbyrussell)
            ZSH_THEME="robbyrussell"
            zinit snippet OMZL::git.zsh
            zinit snippet OMZP::git
            zinit cdclear -q
            setopt promptsubst
            zinit snippet OMZT::robbyrussell
            ;;
        alpharized)
            ZSH_THEME="alpharized"
            zinit snippet OMZL::git.zsh
            zinit snippet OMZP::git
            zinit cdclear -q
            setopt promptsubst
            zinit light NicoSantangelo/Alpharized
            ;;
        *)
            echo "⚠️  未知主题: $theme, 使用默认主题"
            ;;
    esac
}

#-----------------------------------------
# 初始化主题
#-----------------------------------------
__init_theme "${ZSH_THEME:-starship}"


#-----------------------------------------
# 切换主题
#-----------------------------------------
__switch_theme() {
    local theme="$1"
    if [[ -z "$theme" ]]; then
        echo "使用方法: switch_theme [starship|pure|robbyrussell|alpharized]"
        return 1
    fi

    __init_theme "$theme"
    echo "🎨 主题切换为: $theme"
}
