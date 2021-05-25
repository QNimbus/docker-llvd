#!/bin/bash

VERSION=latest
IMAGE=qnimbus/llvd

export DOCKER_CLI_EXPERIMENTAL="enabled"

# Build latest
docker build -t ${IMAGE}:${VERSION} --compress --no-cache --platform linux/amd64 . || exit 1
