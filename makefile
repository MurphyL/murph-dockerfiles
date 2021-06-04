WORK_DIR=$(CURDIR)/src/$(@)
BUILD=docker build -f $(WORK_DIR)/$(@).dockerfile

VERSION?=latest
UNIQUE=murphyl/$(or $(image), alpine):$(VERSION)

jdk:
	$(BUILD) --build-arg JAVA_VERSION=$(or $(JAVA_VERSION), 8) -t murphyl/java$(or $(JAVA_VERSION), 8) $(WORK_DIR)

java: jdk

openjdk: jdk

alpine:
	$(BUILD) -t murphyl/alpine $(WORK_DIR)

nodejs:
	$(BUILD) -t murphyl/$@ $(WORK_DIR)

json-restify:
	$(BUILD) -t murphyl/$@ $(WORK_DIR)

serve-json-restify:
	docker run --rm -it --name json-restify -p 5000:5000 -v $(CURDIR)/src/json-restify/workspace:/usr/murph -v E:/x.json:/usr/murph/editor/x.json murphyl/nodejs npm run start

deploy: 
	docker tag $(UNIQUE) $(UNIQUE)
	ocker push $(UNIQUE)