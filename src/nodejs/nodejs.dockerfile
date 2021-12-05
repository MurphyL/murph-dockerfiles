FROM node:lts-alpine

WORKDIR "/usr/murph"

ARG ALPINE_SOURCE="dl-cdn.alpinelinux.org"
ARG ALPINE_MIRROR="mirrors.tuna.tsinghua.edu.cn"
ARG CNPM_MIRROR="https://registry.npmmirror.com"

ENV TZ Asia/Shanghai
ENV CHOKIDAR_USEPOLLING true

RUN sed -i "s/${ALPINE_SOURCE}/${ALPINE_MIRROR}/g" /etc/apk/repositories; \
	apk update && apk add --no-cache ca-certificates tzdata; \
	npm install yarn -g --registry=${CNPM_MIRROR}; \
	npm install yrm -g --registry=${CNPM_MIRROR};

ENTRYPOINT []
CMD ["/bin/sh"]