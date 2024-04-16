#!/bin/bash

# 定义关联数组
declare -A h5=(
    ["repo"]="git@git.timevale.cn:public_health/esign-certification-h5.git"
    ["branch"]="master"
)

declare -A ppm=(
    ["repo"]="git@git.timevale.cn:public_health/esign-hospital-ppm.git"
    ["branch"]="master"
)

declare -A jquery=(
    ["repo"]="git@git.timevale.cn:public_health/esign-hospital-jquery.git"
    ["branch"]="master"
)

declare -A localSign=(
    ["repo"]="git@git.timevale.cn:public_health/esign-hospital-localsign.git"
    ["branch"]="master"
)

declare -A platform=(
    ["repo"]="git@git.timevale.cn:public_health/esign-user-platform.git"
    ["branch"]="master"
)

declare -A operation=(
    ["repo"]="git@git.timevale.cn:public_health/esign-hospital-operation.git"
    ["branch"]="master"
)

declare -A template=(
    ["repo"]="git@git.timevale.cn:public_health/esign-hospital-template.git"
    ["branch"]="master"
)
