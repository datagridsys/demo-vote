CONTAINER_NAME=demo-vote

.PHONY: container

container:
	docker build -f Dockerfile -t datagridsys/${CONTAINER_NAME} .

