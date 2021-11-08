FROM murphyl/nodejs:latest

WORKDIR "/usr/murph"

COPY ./public/ ./public/
COPY ./config/ ./


# RUN npm install -g json-server
# CMD ["json-server", "--host", "0.0.0.0", "db.json", "--read-only", "--middlewares", "middleware.js"]

RUN npm i serve-json -g
CMD ["serve-json", "db.json"]

# npm install json-server --save-dev

# jmespath、react-json-view、hjson-js、doc-path、serve-json、pharindoko/json-serverless
