##
## author: Piotr Stawarski <piotr.stawarski@zerodowntime.pl>
##

JAVA_VERSIONS += 1.6.0
JAVA_VERSIONS += 1.7.0
JAVA_VERSIONS += 1.8.0
JAVA_VERSIONS += 11

JAVA_VERSION ?= $(lastword $(JAVA_VERSIONS))

CENTOS_VERSION ?= 7

IMAGE_NAME ?= zerodowntime/openjdk
IMAGE_TAG  ?= ${JAVA_VERSION}-centos${CENTOS_VERSION}

build: Dockerfile
	docker build \
		--pull \
	 	--tag "${IMAGE_NAME}:${IMAGE_TAG}" \
		--build-arg "JAVA_VERSION=${JAVA_VERSION}" \
		--build-arg "CENTOS_VERSION=${CENTOS_VERSION}" \
		.

push:
	docker push "${IMAGE_NAME}:${IMAGE_TAG}"

image: build push

clean:
	docker image rm "${IMAGE_NAME}:${IMAGE_TAG}"

runit: build
	docker run -it --rm "${IMAGE_NAME}:${IMAGE_TAG}"

inspect: build
	docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}"

## Here be dragons.

all-images:
	$(foreach VER, $(JAVA_VERSIONS), $(MAKE) all-centos-images JAVA_VERSION=$(VER);)

all-centos-images:
	# $(MAKE) image CENTOS_VERSION=8
	$(MAKE) image CENTOS_VERSION=7
	$(MAKE) image CENTOS_VERSION=7.7.1908
	$(MAKE) image CENTOS_VERSION=7.6.1810
	$(MAKE) image CENTOS_VERSION=7.5.1804
