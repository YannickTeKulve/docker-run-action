#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi


if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi


if [ ! -z $INPUT_DOCKER_HOST ];
then DOCKER_SOCK="-H  unix://$INPUT_DOCKER_HOST"
fi

if [ ! -z $INPUT_DOCKER_HOST ]; then
 exec docker $DOCKER_SOCK run -v "$INPUT_DOCKER_HOST":"$INPUT_DOCKER_HOST" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
else
 exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
fi


