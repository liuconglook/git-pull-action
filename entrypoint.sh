#!/bin/bash
# 任意语句执行的失败都会退出shell
set -e
# 创建ssh秘钥文件
if [ -n "$SSH_PRIVATE_KEY" ]
then
  mkdir -p /root/.ssh
  echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
fi
# 追加主机认证
if [ -n "$SSH_KNOWN_HOSTS" ]
then
  mkdir -p /root/.ssh
  echo "StrictHostKeyChecking yes" >> /etc/ssh/ssh_config
  echo "$SSH_KNOWN_HOSTS" > /root/.ssh/known_hosts
  chmod 600 /root/.ssh/known_hosts
else
  echo "WARNING: StrictHostKeyChecking disabled"
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
fi
# 复制id_rsa、ssh_config、known_hosts到~/.ssh目录下，不需要异常信息，也不管是否复制成功
mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true
# 执行拉取代码的脚本
chmod 700 /git-pull.sh
source "/git-pull.sh" $*
