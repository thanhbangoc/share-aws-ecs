#!/usr/bin/env bash

echo "Start deploy..."
stackName="thanhba-${ENV}"
stackServiceName="thanhba-service-${ENV}"
template="./awsTemplates/ecs-ec2.template.yml"
CLUSTER_NAME="${stackName}-cluster"
SERVICE_NAME=${stackServiceName}

ecrRepositoryUri=( $(aws cloudformation describe-stacks --stack-name $stackName \
          --query 'Stacks[0].Outputs[?OutputKey==`EcrRepositoryUri`].OutputValue' \
          --region ${REGION}  --output text) )
export REPOSITORY_URL=${ecrRepositoryUri}
echo "REPOSITORY_URL: ${REPOSITORY_URL}"

echo "CLUSTER_NAME: ${CLUSTER_NAME}"
echo "SERVICE_NAME: ${SERVICE_NAME}"

echo "Deploy stack name ${stackServiceName}"
aws cloudformation deploy \
    --stack-name ${stackServiceName} \
    --template-file ${template} \
    --capabilities CAPABILITY_NAMED_IAM \
    --region ${REGION} \
    --parameter-overrides EcrImageUri=${REPOSITORY_URL} EcsClusterName=${CLUSTER_NAME}

# aws cloudformation wait stack-create-complete --stack-name ${stackServiceName}

echo "End deploy stack name ${stackServiceName}"

echo "Updating the service..."
aws ecs update-service --region ${REGION} --force-new-deployment --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME}
echo "Updated the service !"

echo "End deploy !"