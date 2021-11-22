#!/bin/sh

set -e

SOURCE_REPO=$1 # 源仓库地址git@github.com:liuconglook/notes.git
DESTINATION_REPO=$2 # 目标仓库地址
SOURCE_DIR=$(basename "$SOURCE_REPO") # notes.git

GIT_SSH_COMMAND="ssh -v"

echo "SOURCE=$SOURCE_REPO"
echo "DESTINATION=$DESTINATION_REPO"

git config --global user.name liucong
git config --global user.email liuconglook@gmail.com
# 克隆项目
git clone "$DESTINATION_REPO" "$SOURCE_DIR" && cd "$SOURCE_DIR"
# 添加源仓库
git remote add dest "$SOURCE_REPO"
mv index.html index
# 更新代码
git pull dest master
# 忽略index文件
mv index index.html
git add index.html
git commit index.html -m'update'
# 提交更新
git push -f origin master
