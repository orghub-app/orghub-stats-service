.PHONY: clean build run stop inspect

IMAGE_NAME = orghub/stats-service
CONTAINER_NAME = orghub-stats-service

dev: 
	FLASK_APP=src/app.py FLASK_DEBUG=1 flask run

install:
	pip3 install -r requirements.txt

test:
	py.test

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run --rm -p 5000:5000 --name $(CONTAINER_NAME) $(IMAGE_NAME)

inspect:
	docker inspect $(CONTAINER_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) /bin/sh

stop:
	docker stop $(CONTAINER_NAME)

clean:
	docker rm -f $$(docker ps -aqf "name=$(CONTAINER_NAME)") || true
	docker rmi -f $$(docker images $(IMAGE_NAME) -q)

publish:
	now && now alias