FROM alpine:latest

WORKDIR "/usr/murph"

ARG JAVA_VERSION=8
ARG ALPINE_SOURCE="dl-cdn.alpinelinux.org"
ARG ALPINE_MIRROR="mirrors.tuna.tsinghua.edu.cn"

ARG NPM_TAOBAO_REGISTRY="https://registry.npm.taobao.org/"

ENV TZ Asia/Shanghai

RUN sed -i "s/${ALPINE_SOURCE}/${ALPINE_MIRROR}/g" /etc/apk/repositories; \
	apk update && apk add --no-cache ca-certificates tzdata;

