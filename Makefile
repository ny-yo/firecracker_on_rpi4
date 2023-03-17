IMAGE_NAME := kernel-build-env

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run --name $(IMAGE_NAME) -it $(IMAGE_NAME) /bin/bash

cp:
	docker create --name $(IMAGE_NAME) -t $(IMAGE_NAME)
	docker cp $(IMAGE_NAME):/usr/src/linux/arch/arm64/boot/Image .
	docker rm -f $(IMAGE_NAME)

stop:
	docker stop $(IMAGE_NAME)

clean:
	docker rm -f $(IMAGE_NAME)

.PHONY: build run stop cp clean
