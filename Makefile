CONTAINER_NAME=demo-vote

.PHONY: container \
		push

container:
	docker build -f Dockerfile -t datagridsys/${CONTAINER_NAME} .

push:
	docker push datagridsys/${CONTAINER_NAME}
