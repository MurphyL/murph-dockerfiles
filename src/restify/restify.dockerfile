FROM murphyl/nodejs:latest

WORKDIR "/usr/murph"

COPY ./workspace/ ./

CMD ["npm", "run", "start"]
