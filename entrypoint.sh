#!/bin/sh -l
cd $1
npm i -g serverless@$2

PACKAGES_TO_INSTALL=$3
if [ $3 != "none" ]; then
    npm i -g ${PACKAGES_TO_INSTALL//,/\ }
fi

WITH_LOCAL_CREDENTIALS=""
if [ $4 = "true" ] || [ $4 = "yes" ]; then
    WITH_LOCAL_CREDENTIALS="--use-local-credentials"
fi

serverless $5 $WITH_LOCAL_CREDENTIALS
