#!/bin/sh

export IMAGE_NAME=rhel7-dev
export IMAGE_REPO=us-west1-docker.pkg.dev/kubeflow-gke-351721/monxun-helm
export BUILD_ID=0.0.1

docker build . -t $IMAGE_NAME:$BUILD_ID
docker run $IMAGE_NAME:$BUILD_ID
# docker tag $IMAGE_NAME:$BUILD_ID $IMAGE_REPO/$IMAGE_NAME:$BUILD_ID
# gcloud auth login
# gcloud auth configure-docker \
#     us-west1-docker.pkg.dev
# docker push $IMAGE_REPO/$IMAGE_NAME --all-tags