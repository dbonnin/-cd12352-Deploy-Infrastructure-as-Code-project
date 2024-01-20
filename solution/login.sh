#!/bin/bash

PROFILE=$1

# Add your AWS access key
aws configure set aws_access_key_id --profile $PROFILE

# Add your AWS secret access key
aws configure set aws_secret_access_key  --profile $PROFILE

# Add your AWS session token
aws configure set aws_session_token "" --profile $PROFILE

# Add your AWS region
aws configure set region us-east-1 --profile $PROFILE

# Add your AWS output format
aws configure set output json --profile $PROFILE
