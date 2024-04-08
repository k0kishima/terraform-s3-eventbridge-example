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
