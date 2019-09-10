# Github Action for Serverless

This Action wraps the [Serverless Framework](https://serverless.com) to enable common Serverless commands.

## Usage
An example workflow to deploy a project with serverless:

### YAML syntax
```
name: Deploy with Serverless

on: push

jobs:
  build:
    name: Build and deploy
    runs-on: ubuntu-latest

    steps:
    - name: checkout code
      uses: actions/checkout@v1

    - name: npm install
      uses: actions/npm@1.0.0
      with:
        args: install

    - name: serverless deploy
      uses: serverless/github-action@master
      with:
        args: deploy
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### HCL syntax
```
workflow "Deploy with Serverless" {
  on = "push"
  resolves = ["serverless deploy"]
}

action "master branch only" {
  uses = "actions/bin/filter@b2bea07"
  args = "branch master"
}

action "npm install" {
  uses = "actions/npm@master"
  args = "install"
  needs = ["master branch only"]
}

action "serverless deploy" {
  uses = "serverless/github-action@master"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  needs = ["npm install"]
  args = "deploy"
}
```

### Secrets

* `AWS_ACCESS_KEY_ID` - **Required**. The AWS Access Key ID
* `AWS_SECRET_ACCESS_KEY` - **Required**. The AWS Secret Access Key


## License

The Dockerfile and associated scripts and documentation in this project are released under the Apache-2 license.
