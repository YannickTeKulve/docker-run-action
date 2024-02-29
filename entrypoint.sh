#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi


if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi


if [ ! -z $INPUT_DOCKER_HOST ];
then INPUT_OPTIONS="$INPUT_OPTIONS --host $INPUT_DOCKER_HOST"
fi

if [ ! -z $INPUT_DOCKER_HOST ];
exec docker run -v "$INPUT_DOCKER_HOST":"$INPUT_DOCKER_HOST" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
else
exec docker run -v "/run/docker/docker.sock":"/run/docker/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
fi


