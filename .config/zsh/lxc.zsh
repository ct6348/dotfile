
#-----------------------------------------
# 进入 Incus 容器并登录指定用户
#-----------------------------------------
__cdins() {
    if [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "用法: cdincus <容器名> <用户名>"
        return 1
    fi
    incus exec "$1" -- sudo --login --user "$2"
}

alias podc='podman-compose'
alias cdins='__cdins'
# alias docker="/usr/bin/podman"


# 进入 Docker 容器的快捷函数
# 用法: cddk <容器名> <用户名>
__cddk() {
    # 检查参数数量
    # if [ "$#" -lgt 3 ]; then
    #     echo "用法: cddk <容器名> <用户> <shell>"
    #     return 1
    # fi

    # 执行进入容器命令
    # -it: 交互式终端
    # -u: 指定用户
    # -w: 指定打开的目录
    # /bin/bash: 尝试进入 bash，如果容器内没 bash 可改为 /bin/sh
    param3=${3:-bash}
    podman exec -it -u "$2" "$1" "/bin/$param3"
}

alias cddk='__cddk'
alias docker='podman' docker-compose='podman-compose'
