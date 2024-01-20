#!/bin/bash

ACTION=$1

USAGE_EMPTY_S3="Usage: run.sh emptyS3 <S3BUCKET> <REGION> <PROFILE>"
USAGE_UPLOAD_S3="Usage: run.sh uploadS3 <S3BUCKET> <REGION> <PROFILE> <FILE>"
USAGE_DEPLOY="Usage: run.sh deploy <STACK_NAME> <TEMPLATE_NAME> <PARMS_NAME> <REGION>"
USAGE_PREVIEW="Usage: run.sh preview <STACK_NAME> <TEMPLATE_NAME> <PARMS_NAME> <REGION>"
USAGE_DELETE="Usage: run.sh delete <STACK_NAME> <REGION>"

if [ "$ACTION" == "emptyS3" ]; then

    S3BUCKET=$2
    REGION=$3
    PROFILE=$4 

    if [ -z "$S3BUCKET" ] || [ -z "$REGION" ] || [ -z "$PROFILE" ]; then
        echo $USAGE_EMPTY_S3
        exit 1
    fi

    aws s3 rm s3://$S3BUCKET --recursive --region=$REGION --profile $PROFILE

elif [ "$ACTION" == "uploadS3" ]; then

    S3BUCKET=$2
    REGION=$3
    PROFILE=$4
    FILE=$5

    if [ -z "$S3BUCKET" ] || [ -z "$REGION" ] || [ -z "$PROFILE" ] || [ -z "$FILE" ]; then
        echo $USAGE_UPLOAD_S3
        exit 1
    fi

    aws s3 cp $FILE s3://$S3BUCKET/ --region=$REGION --profile $PROFILE

elif [ "$ACTION" == "deploy" ]; then

    STACK_NAME=$2
    TEMPLATE_NAME=$3
    PARMS_NAME=$4
    REGION=$5

    if [ -z "$STACK_NAME" ] || [ -z "$TEMPLATE_NAME" ] || [ -z "$PARMS_NAME" ] || [ -z "$REGION" ]; then
        echo $USAGE_DEPLOY
        exit 1
    fi

    aws cloudformation deploy --stack-name $STACK_NAME \
     --template-file $TEMPLATE_NAME --parameter-overrides file://$PARMS_NAME --region=$REGION --profile $PROFILE --capabilities CAPABILITY_NAMED_IAM

elif [ "$ACTION" == "delete" ]; then

    USAGE_DELETE="Usage: run.sh delete <STACK_NAME> <REGION>"

    STACK_NAME=$2
    REGION=$3
    PROFILE=$4

    if [ -z "$STACK_NAME" ] || [ -z "$REGION" ]; then
        echo $USAGE_DELETE
        exit 1
    fi

    aws cloudformation delete-stack --stack-name $STACK_NAME --region=$REGION --profile $PROFILE

elif [ "$ACTION" == "preview" ]; then

    STACK_NAME=$2
    TEMPLATE_NAME=$3
    PARMS_NAME=$4
    REGION=$5

    if [ -z "$STACK_NAME" ] || [ -z "$TEMPLATE_NAME" ] || [ -z "$PARMS_NAME" ] || [ -z "$REGION" ]; then
        echo $USAGE_PREVIEW
        exit 1
    fi

     aws cloudformation deploy --stack-name $STACK_NAME \
     --template-file $TEMPLATE_NAME --parameter-overrides file://$PARMS_NAME --region=$REGION --profile $PROFILE --capabilities CAPABILITY_NAMED_IAM --no-execute-changeset

else
    echo "Invalid action"
fi
