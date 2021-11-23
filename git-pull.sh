#!/bin/sh

set -e

SOURCE_REPO=$1 # 源仓库地址git@github.com:liuconglook/notes.git
DESTINATION_REPO=$2 # 目标仓库地址
IGNORE_FILES=$3 # 忽略文件列表
SOURCE_DIR=$(basename "$SOURCE_REPO") # notes.git

GIT_SSH_COMMAND="ssh -v"

echo "SOURCE=$SOURCE_REPO"
echo "DESTINATION=$DESTINATION_REPO""
echo "IGNORE_FILES=$IGNORE_FILES"

git config --global user.name liucong
git config --global user.email liuconglook@gmail.com

# 拷贝忽略更新的文件
git init ignore && cd ignore
git config core.sparsecheckout true
echo -e "${IGNORE_FILES//,/"\n"}" >> .git/info/sparse-checkout
git remote add origin "$DESTINATION_REPO"
git pull origin master

echo "backups finish."

# 镜像仓库
cd ../
git clone --mirror "$SOURCE_REPO" "$SOURCE_DIR" && cd "$SOURCE_DIR"
git remote set-url --push origin "$DESTINATION_REPO"
git fetch -p origin
# Exclude refs created by GitHub for pull request.
git for-each-ref --format 'delete %(refname)' refs/pull | git update-ref --stdin
git push --mirror

echo "mirror finish."

# 恢复忽略文件
cd ../
git clone "$DESTINATION_REPO" "$SOURCE_DIR" && cd "$SOURCE_DIR"

files=(${IGNORE_FILES//,/ })  
for file in ${files[@]}
do
   mv "../ignore/$file" "./$file"
done

echo "reset ignore file finish."

git add -A
git commit -am'update'
git push origin master

echo "finish."
