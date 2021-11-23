
FROM centos

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
        
RUN apk add --no-cache git openssh-client

ADD *.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh"]
