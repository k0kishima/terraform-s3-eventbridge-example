## Prerequisites

- AWS CLI installed and configured
- Terraform installed
- Node.js and npm installed (if using Node.js for Lambda)

## Deploying Lambda Function

Before running `terraform apply`, you need to create a ZIP file containing the Lambda function code. Follow these steps:

1. Navigate to the directory containing your Lambda function code (e.g., `index.js`):

    ```bash
    cd path/to/your/lambda/function
    ```

2. Create a ZIP file containing your Lambda function code:

    ```bash
    zip lambda_function.zip index.js
    ```

    Replace `index.js` with the name of your Lambda function file if it's different.

3. Make sure the ZIP file is in the same directory as your Terraform configuration files, or update the `filename` attribute in your `aws_lambda_function` resource to point to the correct path of the ZIP file.

## Run terraform apply

Now you can run `terraform apply` to deploy your Lambda function:

```bash
$ terraform apply
```

Confirm the deployment by typing `yes` when prompted.

## Upload a file to the bucket

```bash
$ aws s3 cp ./sample.csv s3://$(terraform output -raw bucket_name)/data/sample.csv
```

## Optional: Using pre-commit for Code Quality Checks

This project supports [pre-commit](https://pre-commit.com/) for automated code quality checks before each commit. Using `pre-commit` is optional, and commits can be made without it. However, it is recommended to use `pre-commit` to maintain code quality.

### Prerequisites

- **Python**: `pre-commit` requires a Python environment. Make sure Python is installed on your system.

### Installing pre-commit

If you choose to use `pre-commit`, install it using:

```bash
$ pip install pre-commit
```

### Setting up pre-commit

To set up `pre-commit` in your local repository, navigate to the project's root directory and run:

```bash
$ pre-commit install
```

This command installs the pre-commit hooks specified in the .pre-commit-config.yaml file.

### Running pre-commit

`pre-commit` will automatically run when you commit your changes. To manually run all pre-commit hooks on all files, use:

```bash
$ pre-commit run --all-files
```

To update the hooks to the latest versions, run:

```bash
$ pre-commit autoupdate
```

### Skipping pre-commit

If you need to bypass the pre-commit checks for a specific commit, you can use:

```bash
$ git commit --no-verify
```
