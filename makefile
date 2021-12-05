WORK_DIR=$(CURDIR)/src/$(@)
BUILD=docker build -f $(WORK_DIR)/$(@).dockerfile --no-cache

VERSION?=latest
UNIQUE=murphyl/$(or $(image), alpine):$(VERSION)

base_images=alpine nodejs restify

jdk:
	$(BUILD) --build-arg JAVA_VERSION=$(or $(JAVA_VERSION), 8) -t murphyl/java$(or $(JAVA_VERSION), 8) $(WORK_DIR)

java: jdk

openjdk: jdk

$(base_images):
	$(BUILD) -t murphyl/$@ $(WORK_DIR)

deploy: 
	docker tag $(UNIQUE) $(UNIQUE)
	docker push $(UNIQUE)