WORK_DIR=$(CURDIR)/src/$(@)
BUILD=docker build -f $(WORK_DIR)/$(@).dockerfile

jdk:
	$(BUILD) --build-arg JAVA_VERSION=$(or $(JAVA_VERSION), 8) -t murphyl/java$(or $(JAVA_VERSION), 8) $(WORK_DIR)

java: jdk

openjdk: jdk

alpine:
	$(BUILD) -t murphyl/alpine $(WORK_DIR)
