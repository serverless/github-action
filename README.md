# Github Action for Serverless

This Action wraps the [Serverless Framework](https://serverless.com) to enable common Serverless commands.

## This project is looking for maintainers!

If you would like to be a maintainer of this project, please reach out to one of the active [Serverless organization](https://github.com/serverless) members to express your interest.

Welcome, and thanks in advance for your help!

## Usage

An example workflow to deploy a project with serverless v3:


```yaml
name: Deploy master branch

on:
  push:
    branches:
      - master

jobs:
  deploy:
    name: deploy
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18.x]
    steps:
    - uses: actions/checkout@v3
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version }}
    - run: npm ci
    - name: serverless deploy
      uses: serverless/github-action@v3.2
      with:
        args: deploy
      env:
        SERVERLESS_ACCESS_KEY: ${{ secrets.SERVERLESS_ACCESS_KEY }}
        # or if using AWS credentials directly
        # AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        # AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Configuration

| `with:` | Description | Required | Default |
| --- | --- | --- | --- |
| `args` | Arguments passed to `serverless` | `true` |
| `aws-credentials` | Whether to use credentials stored in the local environment (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) | `false` |  |
| `install-packages` | Space-separated list of packages to install prior to running `serverless {args}` | `false` |  |
| `serverless-version` | Version of the Serverless Framework to use | `false` | `latest` |
| `working-directory` | Folder where your configuration is located | `false` | `.` |

## Examples

### Minimal example
```yaml
    - name: Deploy
      uses: serverless/github-action@v4.0
      with:
        args: deploy
```

### Use local credentials
```yaml
    - name: Deploy with local credentials
      uses: serverless/github-action@v4.0
      with:
        aws-credentials: true # or yes
        args: deploy
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### Install packages and deploy
```yaml
    - name: Install packages and deploy
      uses: serverless/github-action@v4.0
      with:
        install-packages: serverless-offline serverless-prune-plugin
        args: deploy
```

### Use a particular Serverless Framework CLI version
```yaml
    - name: Deploy using a particular version of serverless
      uses: serverless/github-action@v4.0
      with:
        serverless-version: 2
        args: deploy
```

### Change your working directory
```yaml
    - name: Deploy from a particular working directory
      uses: serverless/github-action@v4.0
      with:
        working-directory: ./foo
        args: deploy
```

## Use a previous version
Change the action with `@{version}`, for example:
```yaml
uses: serverless/github-action@v3.2
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the Apache-2 license.
