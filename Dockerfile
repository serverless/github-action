FROM node:10-slim


LABEL version="1.0.0"
LABEL repository="http://github.com/dschep/sls-actions-test"
LABEL homepage="http://github.com/dschep/sls-actions-test"
LABEL maintainer="Daniel Schep <daniel@serverless.com>"

LABEL "com.github.actions.name"="GitHub Action for Serverless Framework"
LABEL "com.github.actions.description"="Wraps the Serverless Frameork to enable common Serverless commands."
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="red"

RUN npm i -g serverless

ENTRYPOINT ["serverless"]
