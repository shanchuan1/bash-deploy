#!/bin/bash

source ./changeBranch.sh

update_branch "release/ci"

# echo "Repository: ${h5[repo]}, Branch: ${h5[branch]}"

# 输出更新后的数组
for array_name in "h5" "ppm" "jquery" "localSign" "platform" "operation" "template"; do
    declare -n current_array="$array_name"
    echo "Array: $array_name, Branch: ${current_array[branch]}, Repo: ${current_array[repo]}"
done

#输出h5数组
# for key in "${!h5[@]}"; do
#     echo "Key: $key, Value: ${h5[$key]}"
# done