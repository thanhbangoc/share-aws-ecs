#!/usr/bin/env bash

stackName="thanhba-${ENV}"
imageName="thanhba-${ENV}-app"
echo "stackName: ${stackName}"
echo "imageName: ${imageName}"
echo "IMAGE_TAG: ${IMAGE_TAG}"

ecrRepositoryUri=( $(aws cloudformation describe-stacks --stack-name $stackName \
          --query 'Stacks[0].Outputs[?OutputKey==`EcrRepositoryUri`].OutputValue' \
          --region ${REGION}  --output text) )
export REPOSITORY_URL=${ecrRepositoryUri}
echo "REPOSITORY_URL: ${REPOSITORY_URL}"

echo "Building image..."
docker build -t ${imageName}:latest .
# docker build -t ${imageName}:${IMAGE_TAG} .

echo "Tagging latest image..."
docker tag ${imageName}:latest ${REPOSITORY_URL}

echo "Tagging ${IMAGE_TAG} image..."
# docker tag ${imageName}:${IMAGE_TAG} ${REPOSITORY_URL}:${IMAGE_TAG}

echo "Pushing image..."
docker push ${REPOSITORY_URL}
# docker push ${REPOSITORY_URL}:${IMAGE_TAG}

echo "End build image!"