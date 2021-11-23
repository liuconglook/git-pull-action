
FROM centos

RUN apk add --no-cache bash git openssh-client

ADD *.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh"]
