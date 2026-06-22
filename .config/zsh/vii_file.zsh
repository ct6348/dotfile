###################### edit file #######################
# 设置 prefix dir
: ${MY_CONFIG_HOME:=~/.config}

# 定义变量数组（禁用 globbing 并声明全局数组）
typeset -gA zsh_script_file=(
    [zsh]=${MY_CONFIG_HOME}/zsh/zshrc
    [base]=${MY_CONFIG_HOME}/zsh/base.zsh
    [themezsh]=${MY_CONFIG_HOME}/zsh/theme.zsh
    [hs]=${MY_CONFIG_HOME}/zsh/history.zsh
    [vii]=${MY_CONFIG_HOME}/zsh/vii_file.zsh
    [env]=${MY_CONFIG_HOME}/zsh/env.zsh
    [plg]=${MY_CONFIG_HOME}/zsh/plugins.zsh
    [mypx]=${MY_CONFIG_HOME}/zsh/mypx.zsh
    [search]=${search}/zsh/search.zsh
    [web]=${MY_CONFIG_HOME}/zsh/web_search.zsh
    [lxc]=${MY_CONFIG_HOME}/zsh/lxc.zsh
    [rdme]=${MY_CONFIG_HOME}/README.md
    [command]=${MY_CONFIG_HOME}/zsh/command.sh
    [niri]=${MY_CONFIG_HOME}/niri/config.kdl
    [gst]=${MY_CONFIG_HOME}/ghostty/config
    [remote]=${MY_CONFIG_HOME}/zsh/remote.zsh
)

#----------------------------------------
# 编辑指定文件
#----------------------------------------
__vii() {
  if [[ $# -eq 0 ]]; then
      echo "Usage: vii <file_shortcut>"
      echo "Available shortcuts:"
      printf "  %-15s %s\n" "${(k)zsh_script_file[@]}" | sort
      return 1
  fi

  local target_file="${zsh_script_file[$1]}"

  if [[ -n "$target_file" ]]; then
      if [[ -f "$target_file" ]]; then
          nvim "$target_file"
      else
          echo "Error: File not found - $target_file"
          return 1
      fi
  else
      echo "Unknown shortcut: '$1'"
      echo "Run 'vii' without args to see all shortcuts."
      return 1
  fi
}

#----------------------------------------
# reload config file
#----------------------------------------
__reload() {
    # 检查参数
    if [[ $# -eq 0 ]]; then
        echo "Usage: reload <shortcut>"
        echo "Available shortcuts:"
        printf "  %s\n" "${(k)zsh_script_file[@]}"
        return 1
    fi

    # 检查快捷键是否存在
    local target_file="${zsh_script_file[$1]}"
    if [[ -z "$target_file" ]]; then
        echo "Error: Unknown shortcut '$1'"
        echo "Run 'reload' without args to see all shortcuts."
        return 1
    fi

    # 执行 source
    # echo "Reloading $1 ($target_file)..."
    if [[ -f "$target_file" ]]; then
        source "$target_file"
        # source "$target_file" echo "✅ Reloaded successfully!" || echo "❌ Failed to reload."
    else
        echo "❌ File not found: $target_file"
        return 1
    fi
}


alias vii='__vii'
alias reload='__reload'
