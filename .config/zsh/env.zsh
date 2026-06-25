# ---------------------------------
# 自定义脚本
# ---------------------------------
# export PATH=${MY_CONFIG_HOME}/bin:$PATH

export EDITOR=/usr/bin/nvim
export SYSTEMD_EDITOR=/usr/bin/nvim
# export VISUAL=micro
# export VISUAL=lite-xl
export VISUAL=nvim
export TERMINAL=alacritty
# ---------------------------------
# mise 环境
# ---------------------------------
eval "$(mise activate --shims zsh)"

# ---------------------------------
# x-cmd 环境
# ---------------------------------
[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.


# ---------------------------------
# webtop sexxx 插件
# ---------------------------------
# export PATH=$HOME/.local/bin:$PATH

# ---------------------------------
# ai
# ---------------------------------
# fastflowlm 模型下载路径
# export FLM_MODEL_PATH=/data/containers/lxcData/ai
# 魔塔 模型下载路径
# export MODELSCOPE_CACHE=/data/containers/lxcData/ai
# export HF_ENDPOINT="https://hf-mirror.com"
# export HF_ENDPOINT="https://huggingface.co"

# ---------------------------------
# node + npm
# ---------------------------------
# export PATH=$HOME/.local/bin:$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.local/bin:/data/main/lsp/node/npm-global/bin:$PATH
# ---------------------------------
# pnpm
# ---------------------------------
# export PNPM_HOME="/home/chent/.local/share/pnpm"
export PNPM_HOME="/data/main/lsp/node/pnpm/bin"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#让大部分软件（包括浏览器、文件管理器、IDE 等）默认使用 ~/data 下的子目录
# onlyoff "/home/chent/data/work/builddata"

# ---------------------------------
# lsp
# ---------------------------------
# export MAVEN_HOME=/data/main/lsp/java/maven
#export JAVA_HOME=/home/chent/data/main/lsp/java/jdk/corretto-1.8.0_472
# export JAVA_HOME=/home/chent/.local/share/mise/installs/java/corretto-8
# export JRE_HOME=/home/chent/.local/share/mise/installs/java/corretto-8/jre
# export PATH=$PATH:$JAVA_HOME/bin
# export PATH=$PATH:$MAVEN_HOME/bin
# export PATH=$PATH:$MAVEN_HOME/bin:$JAVA_HOME/bin
#

# nodejs nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm to manager nodeJS
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---------------------------------
# rust，备注：cargo 国内镜像源 ~/.cargo/config
# ---------------------------------
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# just 命令管理工具
export JUSTFILE="$HOME/.justfile"
