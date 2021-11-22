# 基于alpine操作系统
FROM alpine
# 安装 Git和ssh客户端
RUN apk add --no-cache git openssh-client
# 拷贝仓库下shell脚本，到系统根目录
ADD *.sh /
# 执行入口shell
ENTRYPOINT ["/entrypoint.sh"]
