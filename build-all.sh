#!/bin/bash

pushd host/2.0/stretch/amd64

NAMESPACE="public"

if [ "$TRAVIS_BRANCH" = "travisci" ]
then
    HOST_TAG="dev"
    IMAGE_TAG="dev-nightly"
else
    HOST_TAG="$TRAVIS_BRANCH"
    IMAGE_TAG="$TRAVIS_BRANCH"
fi

if [ "$TRAVIS_BRANCH" = "travisci" ]
then
    WORKER_TAG="dev"
elif [ "$TRAVIS_BRANCH" = "v2.0.11651-alpha" ]
then
    WORKER_TAG="1.0.224-alpha"
elif [ "$TRAVIS_BRANCH" = "v2.0.11737-alpha" ]
then
    WORKER_TAG="1.0.237-alpha"
elif [ "$TRAVIS_BRANCH" = "v2.0.11776-alpha" ]
then
    WORKER_TAG="1.0.237-alpha"
elif [ "$TRAVIS_BRANCH" = "v2.0.11857-alpha" ]
then
    WORKER_TAG="1.0.237-alpha"
else
    WORKER_TAG="master"
fi

# Build base image
docker build . \
    -t $NAMESPACE/azure-functions-base:$IMAGE_TAG \
    --build-arg NAMESPACE=$NAMESPACE \
    --build-arg HOST_TAG=$HOST_TAG

# Build dotnet image
docker tag $NAMESPACE/azure-functions-base:$IMAGE_TAG \
    $NAMESPACE/azure-functions-dotnet-core:$IMAGE_TAG

# Build node image
pushd node8
docker build . \
    -t $NAMESPACE/azure-functions-node:$IMAGE_TAG \
    --build-arg NAMESPACE=$NAMESPACE \
    --build-arg HOST_TAG=$HOST_TAG
popd

# Build python image
pushd python3.6
docker build . \
    -t $NAMESPACE/azure-functions-python:$IMAGE_TAG \
    --build-arg NAMESPACE=$NAMESPACE \
    --build-arg HOST_TAG=$HOST_TAG \
    --build-arg WORKER_TAG=$WORKER_TAG
popd