#!/bin/bash

# 引入map配置脚本
source ./map.sh

# 修改所有数组的 'branch' 键值
function update_branch {
    new_branch="$1"

    arrays=("h5" "ppm" "jquery" "localSign" "platform" "opreation" "template")

    for array_name in "${arrays[@]}"; do
        declare -n current_array="$array_name" # 创建一个别名引用对应数组
        current_array["branch"]=$new_branch     # 修改 branch 的值
    done
}
