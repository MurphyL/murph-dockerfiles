WORK_DIR=$(CURDIR)/src/$(@)
BUILD=docker build -f $(WORK_DIR)/$(@).dockerfile

VERSION?=latest
UNIQUE=murphyl/$(or $(image), alpine):$(VERSION)

jdk:
	$(BUILD) --build-arg JAVA_VERSION=$(or $(JAVA_VERSION), 8) -t murphyl/java$(or $(JAVA_VERSION), 8) $(WORK_DIR)

java: jdk

openjdk: jdk

alpine:
	$(BUILD) -t murphyl/$@ $(WORK_DIR)

nodejs:
	$(BUILD) -t murphyl/$@ $(WORK_DIR)

json-restify:
	$(BUILD) -t murphyl/$@ $(WORK_DIR)

restify:
#	$(BUILD) -t murphyl/$@ $(WORK_DIR)
	docker run --rm -it --name murphyl-$@ -p 5000:5000 -e SERVE_PORT=5000 -v $(CURDIR)/src/$@/workspace:/usr/murph murphyl/nodejs npm run start

serve-json-restify:
	docker run --rm -it --name json-restify -p 5000:5000 -v $(CURDIR)/src/json-restify/workspace:/usr/murph -v E:/x.json:/usr/murph/editor/x.json murphyl/nodejs npm run start

deploy: 
	docker tag $(UNIQUE) $(UNIQUE)
	docker push $(UNIQUE)