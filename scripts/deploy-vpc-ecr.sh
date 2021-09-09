echo "Start deploy infra ..."
############ STACK VPC ###########
stackName="thanhba-${ENV}"
template="./awsTemplates/vpc-ecr.template.yml"

# Create stack
echo "Deploy stack name ${stackName}"
aws cloudformation deploy \
    --stack-name ${stackName} \
    --template-file ${template} \
    --capabilities CAPABILITY_NAMED_IAM \
    --region ${REGION}

# aws cloudformation wait stack-create-complete --stack-name ${stackName}

echo "End deploy stack name ${stackName}"