#!/bin/bash

ACTION=$1
STACK_NAME=$2
TEMPLATE_NAME=$3
PARMS_NAME=$4
REGION=$5

if [ $ACTION == "deploy" ]; then
    aws cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file $TEMPLATE_NAME \
        --parameter-overrides file://$PARMS_NAME \
        --region=$REGION
elif [ $ACTION == "delete" ]; then
    aws cloudformation delete-stack \
        --stack-name $STACK_NAME \
        --region=$REGION
elif [ $ACTION == "preview" ]; then
    aws cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file $TEMPLATE_NAME \
        --parameter-overrides file://$PARMS_NAME \
        --region=$REGION \
        --no-execute-changeset
elif [ $ACTION == "describe" ]; then
    aws cloudformation describe-stacks \
        --stack-name $STACK_NAME \
        --region=$REGION
elif [ $ACTION == "list" ]; then
    aws cloudformation list-stacks \
        --region=$REGION
elif [ $ACTION == "events" ]; then
    aws cloudformation describe-stack-events \
        --stack-name $STACK_NAME \
        --region=$REGION
elif [ $ACTION == "outputs" ]; then
    aws cloudformation describe-stacks \
        --stack-name $STACK_NAME \
        --query 'Stacks[].Outputs' \
        --region=$REGION
elif [ $ACTION == "validate" ]; then
    aws cloudformation validate-template \
        --template-body file://$TEMPLATE_NAME \
        --region=$REGION
elif [ $ACTION == "get" ]; then
    aws cloudformation get-template \
        --stack-name $STACK_NAME \
        --region=$REGION
else
    echo "Usage: ./run.sh [deploy|delete|describe|list|events|outputs|validate|get|preview] [stack-name] [template-name] [parameters-name] [region]"
fi
