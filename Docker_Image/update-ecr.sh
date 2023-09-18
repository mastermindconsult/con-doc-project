#!/bin/bash
REPO_NAME="ecr_repo"
ECR_ACCOUNT="public.ecr.aws/171053147134"
ECR_REPO="${ECR_ACCOUNT}/${REPO_NAME}"
TAG="ecr_repo"
#Login to the Docker registry on ECR.
aws ecr-public get-login-password --region us-east-1  | sed -e 's/^.*-p \(.*\)\s\-\e.*$/\1/' |  docker login --password-stdin -u AWS "${ECR_ACCOUNT}"
#Build the image
docker build -t "${TAG}" .
# Push using the commit tag.
docker tag "${TAG}:latest" "${ECR_REPO}:latest"
#Push using the latest tag.
docker push "${ECR_REPO}:latest"
