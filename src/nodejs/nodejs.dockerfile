FROM node:lts-alpine

WORKDIR "/usr/murph"

ARG ALPINE_SOURCE="dl-cdn.alpinelinux.org"
ARG ALPINE_MIRROR="mirrors.tuna.tsinghua.edu.cn"

ENV TZ Asia/Shanghai
ENV CHOKIDAR_USEPOLLING true

RUN sed -i "s/${ALPINE_SOURCE}/${ALPINE_MIRROR}/g" /etc/apk/repositories; \
	apk update && apk add --no-cache ca-certificates tzdata; 
