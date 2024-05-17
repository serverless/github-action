#!/bin/sh -l
npm i -g serverless@${1/v/}
serverless $2
