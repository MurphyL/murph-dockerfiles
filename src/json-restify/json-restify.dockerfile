FROM murphyl/nodejs:latest

WORKDIR "/usr/murph"

COPY ./workspace/ ./

CMD ["npm", "run", "start"]

# npm install json-server --save-dev

# jmespath、react-json-view、hjson-js、doc-path、serve-json、pharindoko/json-serverless
