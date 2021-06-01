FROM alpine:latest

WORKDIR "/usr/murph"

ARG ALPINE_SOURCE="dl-cdn.alpinelinux.org"
ARG ALPINE_MIRROR="mirrors.tuna.tsinghua.edu.cn"

ARG NPM_TAOBAO_REGISTRY="https://registry.npm.taobao.org/"

ENV TZ Asia/Shanghai
ENV CHOKIDAR_USEPOLLING true

RUN sed -i "s/${ALPINE_SOURCE}/${ALPINE_MIRROR}/g" /etc/apk/repositories; \
	apk update && apk add --no-cache ca-certificates tzdata nodejs npm; \
	npm config set registry ${NPM_TAOBAO_REGISTRY}
