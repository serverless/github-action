#!/bin/sh -l
cd $1
npm i -g serverless@${2/v/}
serverless $3
