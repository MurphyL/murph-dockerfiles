#!/usr/bin/env bash

nohup mongod --port ${MONGO_PORT} --bind_ip_all --logpath $(pwd)/logs/mongo-$(date '+%F').log --dbpath $(pwd)/mongo/data --directoryperdb > /dev/null 2>&1 &

nohup java -Dfile.encoding=UTF-8 -jar -server ${RH_ROOT}/restheart.jar --fork ${RH_ROOT}/etc/restheart.yml -e ${RH_ENV_FILE} > /dev/null 2>&1 &