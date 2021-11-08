unique=murphyl/json-restify
build:
	docker build -f $(CURDIR)/json-restify.dockerfile --no-cache -t $(unique) $(CURDIR)
	docker run --rm -it -p 5000:3000 -v E:/x.json:/usr/murph/db.json $(unique)
