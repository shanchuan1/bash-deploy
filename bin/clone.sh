#!/bin/bash

# 加载外部脚本
source ./map.sh
source ./dirname.sh

# 设置本地路径，Git 仓库地址和要拉取的分支默认值
local_path="hospital"
# 获取根路径
getRootPath
echo "ROOT_PATH: $ROOT_PATH"
# git_repo="git@git.timevale.cn:public_health/esign-certification-h5.git"
# branch_name="master"

# git_repo="${h5[repo]}"
# branch_name="${h5[branch]}"

# echo $git_repo
# echo $branch_name

function cloneGitRepo {
    local git_repo=$1
    local branch_name=$2
    local current_dir=$(pwd)
    local rootPath=$ROOT_PATH

    cd "$rootPath"
    # echo $git_repo
    # echo $branch_name
    echo "rootPath: $rootPath"

    # return 
    # 获取项目文件夹名
    new_folder_name=$(basename "$git_repo" .git)

    # 检查本地路径是否存在，不存在则创建
    if [ ! -d "$local_path" ]; then
        mkdir -p "$local_path"
    else
        cd "$local_path"
        # 如果目录已存在内容，获取当前分支名称
        if [ ! -d "$new_folder_name" ]; then
            mkdir -p "$new_folder_name"
        fi
        cd "$new_folder_name"
        current_branch=$(git branch --show-current)
        cd ../..
    fi

    # 切换到本地路径
    cd "$local_path" || exit

    if [ -d "$new_folder_name" ]; then
        cd "$new_folder_name" || exit
    fi

    if [ -d ".git" ]; then
        # 如果已经是一个 Git 仓库，执行 git pull 命令来更新code

        # 判断当前分支是否等于传入的分支
        if [ "$current_branch" = "$branch_name" ]; then
            git pull origin "$branch_name"
            echo "当前分支与传入的分支相同: $current_branch, 拉取最新code成功"
        else
            echo "当前分支为: $current_branch, 传入的分支为：$branch_name, 准备切换分支code"

            # 使用 `git branch` 获取本地分支列表，并通过 grep 查找特定分支
            branches=$(git branch | grep "^ *$branch_name")

            # 检查 grep 是否找到了匹配项
            if [[ -n "$branches" ]]; then
                echo "分支 '$branch_name' 存在于本地"
                git checkout $branch_name
            else
                echo "分支 '$branch_name' 不存在于本地"
                git checkout -b $branch_name origin/$branch_name
            fi
            echo "项目分支切换成功: $(git branch --show-current)"
        fi
    else
        echo "拉取整个项目"
        cd $rootPath/$local_path
        echo "pwd: $(pwd)"

        git clone $git_repo

        # 获取当前目录下新创建的目录名
        echo "新创建的项目文件夹名为: $new_folder_name"

        # 查看当前分支
        echo "项目拉取成功，当前分支: $(cd "$new_folder_name" && git branch --show-current)"
    fi
    
    echo "pwd: $(pwd)"
    cd $rootPath
    echo "pwd: $(pwd)"
    # 拉取完成
    echo "仓库: $git_repo 分支: $branch_name 的code已拉取成功"
}

# cloneGitRepo



function cloneAllRepo {
    # for array_name in "h5" "ppm" "jquery" "localSign" "platform" "operation" "template"; do
    for array_name in "h5" "ppm" ; do
    declare -n current_array="$array_name"
    # echo "Branch: ${current_array[repo]}, Repo: ${current_array[branch]}"
    cloneGitRepo "${current_array[repo]}" "${current_array[branch]}"
    done
}

cloneAllRepo





# server_username="your_username"
# server_ip="server_ip_address"
# server_path="/path/to/server/directory"

# 执行 yarn build
# yarn install  # 安装依赖，如果需要的话
# yarn build    # 执行打包命令

# # 上传 dist 文件夹到服务器
# scp -r "$local_path/dist" "$server_username@$server_ip:$server_path"

# # 提示操作完成
# echo "分支 $branch_name 的code已拉取并成功构建到：$local_path"
# echo "dist 文件夹已上传到服务器：$server_username@$server_ip:$server_path"
