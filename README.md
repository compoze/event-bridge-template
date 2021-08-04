# AWS EventBridge

This repository contains terraform templates to create and manage an AWS EventBridge

## How to use this repo

This repository leverages [Terraform Cloud](https://app.terraform.io/app/organizations) to manage the execution of terraform commands. All of the commands are managed by a central Makefile, in this repository, for ease of use. The following commands are available (these are also available via ```make help```)

1. **install**:                        Download and install terraform in /usr/local/bin/terraform. Should work on Linux, MacOS and WSL
2. **login**:                          Login to the terraform cloud organization.
3. **dev**:                            Select the dev workspace.
4. **prod**:                           Select the production workspace.
5. **stage**:                          Select the stage workspace
6. **plan**:                           Show terraform plan for the current workspace.
7. **apply**:                          Apply plan. Output shows terraform cloud url

For example, if you want to make a change and apply it to the dev environment, for the first time, you would perform the following commands:

```bash
make install
make login
make dev
make plan
make apply
```
