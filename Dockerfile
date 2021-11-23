
FROM alpine
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
RUN apk add --no-cache git openssh-client

ADD *.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh"]
