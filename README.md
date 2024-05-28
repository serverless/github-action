# Github Action for Serverless

This Action wraps the [Serverless Framework](https://serverless.com) to enable common Serverless commands.

## Usage

An example workflow to deploy a project with the Serverless Framework:

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
      uses: ryanlawson/serverless-github-action@v1.0
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
Basic deployment with no customization
```yaml
    - name: Deploy
      uses: ryanlawson/serverless-github-action@v1.0
      with:
        args: deploy
```

### Use local credentials
Ensures `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are present and uses them to authenticate
```yaml
    - name: Deploy with local credentials
      uses: ryanlawson/serverless-github-action@v1.0
      with:
        aws-credentials: true # or yes
        args: deploy
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### Install packages and deploy
Installs any additional packages (usually [Serverless plugins](https://www.serverless.com/plugins)) prior to deploying
```yaml
    - name: Install packages and deploy
      uses: ryanlawson/serverless-github-action@v1.0
      with:
        install-packages: serverless-offline serverless-prune-plugin
        args: deploy
```

### Use a particular Serverless Framework CLI version
Installs a specific version of the Serverless Framework
```yaml
    - name: Deploy using a particular version of serverless
      uses: ryanlawson/serverless-github-action@v1.0
      with:
        serverless-version: 2
        args: deploy
```

### Change your working directory
Sets a specific working directory (usually the root of the repository) for your Serverless configuration
```yaml
    - name: Deploy from a particular working directory
      uses: ryanlawson/serverless-github-action@v1.0
      with:
        working-directory: ./foo
        args: deploy
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the Apache-2 license.
