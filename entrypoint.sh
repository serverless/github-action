#!/bin/sh -l
if [ "$5" = "none" ]; then
    echo "You need to specify at least one argument, like deploy"
    exit 5
fi

WITH_LOCAL_CREDENTIALS=""
if [ "$1" = "true" ] || [ "$1" = "yes" ]; then
    if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
        echo "You have aws-credentials set without AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY"
        exit 1
    fi
    WITH_LOCAL_CREDENTIALS="--use-local-credentials"
fi

cd $2
if [ "$?" != 0 ]; then
    echo "Unable to cd into $2"
    exit 2
fi

npm i -g serverless@$3
if [ "$?" != 0 ]; then
    echo "Unable to install serverless@$3"
    exit 3
fi

if [ "$4" != "none" ]; then
    npm i -g $4
    if [ "$?" != 0 ]; then
        echo "Unable to install packages: $4"
        exit 4
    fi
fi

echo serverless $5 $WITH_LOCAL_CREDENTIALS
serverless $5 $WITH_LOCAL_CREDENTIALS
