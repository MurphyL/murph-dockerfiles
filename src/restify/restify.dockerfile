FROM softinstigate/restheart:latest

WORKDIR /usr/murph

ARG UBUNTU_SOURCE="security.ubuntu.com"
ARG UBUNTU_MIRROR="mirrors.tuna.tsinghua.edu.cn"

ENV RH_ROOT=/opt/restheart

ENV RH_DATABASE=${RH_DATABASE:-murph}

ENV MONGO_PORT=27017
ARG MONGO_URI="127.0.0.1:${MONGO_PORT}"

RUN sed -i "s/${UBUNTU_SOURCE}/${UBUNTU_MIRROR}/g" /etc/apt/sources.list; \
    apt update && apt upgrade -y && apt install -y --no-install-recommends mongodb; \
    mkdir -p $(pwd)/mongo/data $(pwd)/logs; \
    echo "enable-log-file=true" >> ./restheart.env;  \
    echo "log-file-path=$(pwd)/logs/restheart-$(date '+%F').log" >> ./restheart.env;  \
    echo "enable-log-console=true" >> ./restheart.env; \
    echo "log-level=INFO" >> ./restheart.env; \
    echo "https-listener=false" >> ./restheart.env; \
    echo "https-host=0.0.0.0" >> ./restheart.env; \
    echo "https-port=4443" >> ./restheart.env; \
    echo "http-listener=true" >> ./restheart.env; \
    echo "http-host=0.0.0.0" >> ./restheart.env; \
    echo "http-port=8080" >> ./restheart.env; \
    echo "ajp-listener=false" >> ./restheart.env; \
    echo "ajp-host=0.0.0.0" >> ./restheart.env; \
    echo "ajp-port=8009" >> ./restheart.env; \
    echo "users-conf-file=${RH_ROOT}/etc/users.yml" >> ./restheart.env; \
    echo "acl-conf-file=${RH_ROOT}/etc/acl.yml" >> ./restheart.env; \
    echo "plugins-directory=${RH_ROOT}/plugins" >> ./restheart.env; \
    echo "root-mongo-resource=/${RH_DATABASE}/" >> ./restheart.env; \
    echo "worker-threads=32" >> ./restheart.env; \
    echo "io-threads=5" >> ./restheart.env; \
    echo "instance-name=rest-mongo" >> ./restheart.env; \
    echo "mongo-uri=mongodb://${MONGO_URI}/?authSource=authdb" >> ./restheart.env; \
    echo "nohup mongod --port ${MONGO_PORT} --bind_ip_all --logpath $(pwd)/logs/mongo-$(date '+%F').log --dbpath $(pwd)/mongo/data --directoryperdb > /dev/null 2>&1 &" >> ./start.sh; \
    echo "java -Dfile.encoding=UTF-8 -jar -server ${RH_ROOT}/restheart.jar ${RH_ROOT}/etc/restheart.yml -e ./restheart.env" >> ./start.sh; \
    chmod u+x ./start.sh

ENTRYPOINT []

CMD ["/bin/sh", "-c", "/usr/murph/start.sh"]