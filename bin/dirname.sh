#!/bin/bash
function getRootPath {
    # 获取当前脚本所在的绝对路径
    local script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

    # 获取上两级目录的路径
    local desired_path=$(dirname "$(dirname "$script_dir")")

    #输出最终结果
    # echo "$desired_path/"

    export ROOT_PATH="$desired_path"
}

