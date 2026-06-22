# ── Format Tools ────────────────────────────────────────────────────────────
# 用法：
#   just --list              列出所有命令
#   just --choose            用 fzf 搜索和选择
#   just fmt <路径>          格式化单个文件
#   just clip                格式化剪贴板
#   just <扩展名>            格式化当前目录下所有该类型文件
#   just tools               查看已安装的格式化工具版本
# ─────────────────────────────────────────────────────────────────────────────

# 格式化单个文件（自动检测类型）
fmt path:
    ~/.local/share/vicinae/scripts/dev/format-file.sh {{path}}

# 格式化剪贴板内容
clip:
    ~/.local/share/vicinae/scripts/dev/format-clipboard.sh

# ── 批量格式化当前目录下特定类型的文件 ──────────────────────────────────────

# 格式化所有 JSON
json:
    fd -e json -X sh -c 'jq "." "$1" > "$1.tmp" && mv "$1.tmp" "$1" || rm -f "$1.tmp"' _ {}

# 格式化所有 YAML
yaml:
    fd -e yaml -e yml -X sh -c 'yq -P "$1" > "$1.tmp" && mv "$1.tmp" "$1" || rm -f "$1.tmp"' _ {}

# 格式化所有 Shell 脚本
sh:
    fd -e sh -e bash -X shfmt -w {}

# 格式化所有 Go 文件
go:
    fd -e go -X gofmt -w {}

# 格式化所有 Rust 文件
rs:
    fd -e rs -X rustfmt {}

# 格式化所有 C/C++
c:
    fd -e c -e cpp -e h -e hpp -X clang-format -i {}

# 格式化所有 Nginx 配置
nginx:
    fd -e nginx -e nginxconf -X nginx-config-formatter -p {} -i space -a

# 格式化当前目录所有支持的代码文件（dprint 大统一）
all:
    dprint fmt

# ── 其他工具 ─────────────────────────────────────────────────────────────────

# 列出已安装的格式化工具版本
tools:
    @printf "%-20s %s\n" "Tool" "Version"
    @printf "%-20s %s\n" "----" "-------"
    @printf "%-20s %s\n" "dprint"   "$(dprint --version 2>&1)"
    @printf "%-20s %s\n" "shfmt"    "$(shfmt --version 2>&1)"
    @printf "%-20s %s\n" "jq"       "$(jq --version 2>&1)"
    @printf "%-20s %s\n" "yq"       "$(yq --version 2>&1)"
    @printf "%-20s %s\n" "gofmt"    "$(gofmt --version 2>&1)"
    @printf "%-20s %s\n" "rustfmt"  "$(rustfmt --version 2>&1)"
    @printf "%-20s %s\n" "clang-format" "$(clang-format --version 2>&1)"
    @printf "%-20s %s\n" "xmllint"  "$(xmllint --version 2>&1 | head -1)"
    @printf "%-20s %s\n" "nginx-config-formatter" "$(nginx-config-formatter --version 2>&1)"
