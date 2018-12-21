# GitHub Deployer for Serverless

This Action wraps the [Serverless Framework](https://serverless.com) to enable common Serverless commands.

## Usage
An example workflow to deploy a project with serverless:


```
workflow "Deploy with Serverless" {
  on = "push"
  resolves = "release"
}

action "serverless deploy" {
  uses = "serverless/github-action@master"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  args = "deploy"
}
```

### Secrets

* `AWS_ACCESS_KEY_ID` - **Required**. The AWS Access Key ID
* `AWS_SECRET_ACCESS_KEY` - **Required**. The AWS Secret Access Key


## License

The Dockerfile and associated scripts and documentation in this project are released under the Apache-2 license.
