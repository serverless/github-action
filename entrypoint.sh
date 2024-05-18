#!/bin/sh -l
if [ "$5" = "none" ]; then
    echo "You need to specify at least one argument, like deploy"
    exit 1
fi

cd $1

npm i -g serverless@$2

if [ "$3" != "none" ]; then
    npm i -g $3
fi

WITH_LOCAL_CREDENTIALS=""
if [ "$4" = "true" ] || [ "$4" = "yes" ]; then
    WITH_LOCAL_CREDENTIALS="--use-local-credentials"
fi

serverless $5 $WITH_LOCAL_CREDENTIALS
