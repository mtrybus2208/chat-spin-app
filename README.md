# chat-spin-app

## Getting Started

### Step 1: Initialize Terraform

```bash
npm run terraform:init
```

### Step 2: Build Lambda Handlers and Apply Terraform Configuration

```bash
npm run deploy
```

### Other commands:

##### Build Lambda Handlers

Navigate to the project root directory and run the following command to build the Lambda handlers:

```bash
npm run build-lambda-handlers
```

##### Initialize Terraform

```bash
npm run terraform:init
```

##### Apply Terraform Configuration

```bash
npm run deploy
```

##### Destroy Terraform Resources

If you need to destroy the resources created by Terraform, run:

```bash
npm run destroy
```

##### tfvars example

You need to create separate files for prod and dev e.g. dev.tfvars and prod.tfvars and add values like

```bash
environment     = "dev"
allowed_origins = "*"

```
