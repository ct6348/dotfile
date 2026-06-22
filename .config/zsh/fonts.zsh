#-----------------------------------------
# 字体安装管理器 — install_font
# 用法: install_font           # 安装/更新所有已配置字体
#       install_font maple     # 仅安装/更新 maple
#       install_font list      # 列出已配置字体和版本状态
#-----------------------------------------

# --- 公共前缀 ---
FONT_GH_RELEASES="https://github.com"
FONT_GH_API="https://api.github.com/repos"

# --- 版本记录（按仓库/子目录保存 tag）---
FONT_VERSION_FILE="${HOME}/.local/share/fonts/.font-versions"

# --- 字体定义 ---
# 格式: "GitHub仓库|目标子目录|下载Assets(逗号分隔)"
#   GitHub仓库  → owner/repo
#   目标子目录  → 解压到 ~/.local/share/fonts/<子目录>/
#   下载Assets  → 发行版附件名（支持通配，多个用逗号隔开）
typeset -ga FONT_LIST=(
    "subframe7536/maple-font|maple|MapleMono-NF-CN.zip,MapleMono-CN.zip"
    # ── 以后新增字体在这里加行 ──
    "ryanoasis/nerd-fonts|FiraCode|FiraCode.zip"
    "be5invis/Sarasa-Gothic|sarasa|SarasaTTC-*.zip"
    "source-foundry/Hack|hack|Hack-*.zip"
)

# --- 获取 GitHub 最新 tag ---
_font_latest_tag() {
    local repo="$1"
    curl -fsSL "${FONT_GH_API}/${repo}/releases/latest" \
        | grep '"tag_name"' \
        | cut -d'"' -f4
}

# --- 读取已安装版本 ---
_font_installed_ver() {
    local key="$1"
    [[ -f "$FONT_VERSION_FILE" ]] || return 1
    grep -s "^${key}:" "$FONT_VERSION_FILE" | cut -d':' -f2-
}

# --- 写入已安装版本 ---
_font_set_ver() {
    local key="$1" tag="$2"
    mkdir -p "$(dirname "$FONT_VERSION_FILE")"
    if grep -qs "^${key}:" "$FONT_VERSION_FILE" 2>/dev/null; then
        sed -i "s|^${key}:.*|${key}:${tag}|" "$FONT_VERSION_FILE"
    else
        echo "${key}:${tag}" >> "$FONT_VERSION_FILE"
    fi
}

# --- 主函数 ---
install_font() {
    local filter="$1"

    # list 子命令：查看配置和版本状态
    if [[ "$filter" == "list" ]]; then
        print "Configured fonts:"
        for entry in "${FONT_LIST[@]}"; do
            local repo="${entry%%|*}"
            local rest="${entry#*|}"
            local dir="${rest%%|*}"
            local assets="${rest#*|}"
            local fonts_dir="${HOME}/.local/share/fonts/${dir}"
            local ver="$(_font_installed_ver "${repo}/${dir}")"
            local status="  ${dir}  (${repo})"
            [[ -n "$ver" ]] && status+="  installed: ${ver}" || status+="  [not installed]"
            [[ -d "$fonts_dir" ]] || status+="  (dir missing)"
            print "$status"
        done
        return 0
    fi

    for entry in "${FONT_LIST[@]}"; do
        # 解析
        local repo="${entry%%|*}"
        local rest="${entry#*|}"
        local dir="${rest%%|*}"
        local assets="${rest#*|}"
        local fonts_dir="${HOME}/.local/share/fonts/${dir}"
        local ver_key="${repo}/${dir}"

        # 如果指定了字体名，只处理匹配的
        [[ -n "$filter" && "$filter" != "$dir" ]] && continue

        print "==> ${dir}  ←  ${repo}"

        # 获取最新 tag
        local tag="$(_font_latest_tag "$repo")"
        [[ -z "$tag" ]] && { print "  ✗  Failed to get latest tag"; continue; }

        # 检查版本
        local current_tag="$(_font_installed_ver "$ver_key")"
        if [[ -d "$fonts_dir" && "$current_tag" == "$tag" ]]; then
            print "  ✓  Already up-to-date  (${tag})"
            continue
        fi

        if [[ -z "$current_tag" ]]; then
            print "  ↓  Installing ${tag} ..."
        else
            print "  ↻  Updating  ${current_tag}  →  ${tag} ..."
        fi

        # 下载 & 解压
        local tmpdir=$(mktemp -d)
        local IFS=,
        for asset in ${(s:,:)assets}; do
            print "     Downloading ${asset} ..."
            curl -fsSL -o "${tmpdir}/${asset}" \
                "${FONT_GH_RELEASES}/${repo}/releases/download/${tag}/${asset}" \
                || { print "  ✗  Download failed: ${asset}"; continue }
            print "     Extracting ..."
            unzip -qo "${tmpdir}/${asset}" -d "$tmpdir" 2>/dev/null \
                || print "     (not a zip, skipped unzip)"
            rm -f "${tmpdir}/${asset}"
        done

        # 移动字体文件到目标目录
        mkdir -p "$fonts_dir"
        local count=0
        find "$tmpdir" \( -name '*.ttf' -o -name '*.otf' \) -exec mv {} "$fonts_dir" \; \
            -exec count=\$((count + 1)) \; 2>/dev/null
        # 没有 find -exec 计数时用简单方式
        local ttf_count=$(find "$tmpdir" \( -name '*.ttf' -o -name '*.otf' \) | wc -l)
        if [[ $ttf_count -gt 0 ]]; then
            find "$tmpdir" \( -name '*.ttf' -o -name '*.otf' \) -exec mv {} "$fonts_dir" \;
        fi
        rm -rf "$tmpdir"

        # 刷新字体缓存
        print "     Refreshing font cache ..."
        fc-cache -f "${HOME}/.local/share/fonts" 2>/dev/null || true

        # 记录版本
        _font_set_ver "$ver_key" "$tag"
        print "  ✓  Done  (${ttf_count:-0} files → ${fonts_dir})"
    done
}
