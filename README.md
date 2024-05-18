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

## Specify a particular version
```yaml
    - name: Deploy with a particular version
      uses: serverless/github-action@v3.2
      with:
        serverless-version: 3
        args: deploy
```

## Change your working directory
```yaml
    - name: Deploy from a particular working directory
      uses: serverless/github-action@v3.2
      with:
        working-directory: ./foo
        args: deploy
```

## Usage with serverless plugins
Change your action in this way, according to [this issue](https://github.com/serverless/github-action/issues/28), thanks to @matthewpoer:
```yaml
    - name: Install Plugin and Deploy
      uses: serverless/github-action@v3.2
      with:
        args: -c "serverless plugin install --name <plugin-name> && serverless deploy"
        entrypoint: /bin/sh
```

## Fix "This command can only be run in a Serverless service directory" error
Change your action in this way, according to [this issue](https://github.com/serverless/github-action/issues/53#issuecomment-1059839383), thanks to @nikhuber:
```yaml
    - name: Enter dir and deploy
      uses: serverless/github-action@v3.2
      with:
        args: -c "cd ./<your-dir> && serverless deploy"
        entrypoint: /bin/sh
```


## Use serverless v1 or v2
Change the action with one of the following:
```yaml
uses: serverless/github-action@v1
```
```yaml
uses: serverless/github-action@v2
```


## License

The Dockerfile and associated scripts and documentation in this project are released under the Apache-2 license.
