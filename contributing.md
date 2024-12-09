# Contributing to [Your Project Name]

Thank you for considering contributing to our project! To ensure a smooth and consistent workflow, please follow these guidelines.

## Branching Strategy

- **Main Branch**: The `main` branch is the production-ready branch. Direct commits and pushes to this branch are not allowed.
- **Development Branch**: The `development` branch is used for ongoing development. Direct commits and pushes to this branch are not allowed.
- **Feature Branches**: Create feature branches from the `development` branch. Use the naming convention `feature/your-feature-name`.

## Pull Requests

- **Source Branch**: Pull requests to the `main` branch are only allowed from `development` branches. Direct PRs from `feature/*` branches to `main` are not allowed.
- **Commit Messages**: Ensure that all commit messages follow the conventional commit format. Valid commit types include `fix`, `feat`, `chore`, `docs`, `style`, `refactor`, `test`, `ci`, and `release`.

### Example Commit Message

```
feat(parser): add ability to parse arrays
```

Ensure that all commit messages follow the conventional commit format. Valid commit types include `fix`, `feat`, `chore`, `docs`, `style`, `refactor`, `test`, `ci`, and `release`.

## Local Development

### Pre-commit Hook

We have a pre-commit hook to enforce branch protection and commit message format. The hook will:
- Prevent commits directly to the `main` or `development` branches.
- Validate commit messages to ensure they follow the conventional commit format.

### Pre-push Hook

We have a pre-push hook to enforce branch protection. The hook will:
- Prevent pushes directly to the `main` or `development` branches.

### Setting Up Git Hooks

To set up the Git hooks locally, ensure the following scripts are in place:

#### Pre-commit Hook

Create a file named `.git/hooks/pre-commit` with the following content:

```bash
#!/bin/bash

# Get the current branch name
branch_name=$(git symbolic-ref --short HEAD)

# List of protected branches
protected_branches=("main" "development")

# Check if the current branch is protected
for branch in "${protected_branches[@]}"; do
    if [ "$branch_name" == "$branch" ]; then
        echo "You are not allowed to commit directly to the $branch branch."
        echo "Please create a new branch and make your changes there."
        exit 1
    fi
done

# Fetch the commit message
commit_msg_file=$1
commit_msg=$(cat "$commit_msg_file")

# Define the conventional commit regex
conventional_commit_regex="^(fix|feat|chore|docs|style|refactor|test|ci|release)\(.+\):\ .+"

# Validate the commit message
if ! echo "$commit_msg" | grep -Eq "$conventional_commit_regex"; then
    echo "Invalid commit message: $commit_msg"
    echo "Commit message must follow the conventional commit format."
    exit 1
fi
```

Make the hook executable:

```bash
chmod +x .git/hooks/pre-commit
```

#### Pre-push Hook

Create a file named `.git/hooks/pre-push` with the following content:

```bash
#!/bin/sh

# Get the current branch name
BRANCH_NAME=$(git symbolic-ref --short HEAD)

# List of protected branches
protected_branches=("main" "development")

# Check if the current branch is protected
for branch in "${protected_branches[@]}"; do
    if [ "$BRANCH_NAME" = "$branch" ]; then
        echo "You cannot push directly to the $BRANCH_NAME branch."
        echo "Please create a pull request instead."
        exit 1
    fi
done
```

Make the hook executable:

```bash
chmod +x .git/hooks/pre-push
```

## Continuous Integration

### Restrict PRs to Main and Validate Commits

- **Source Branch**: Disallows direct PRs from `feature/*` branches to `main`. Allows PRs from `dev*` or `development` branches to `main`.
- **Commit Messages**: Ensures that all commit messages follow the conventional commit format.
- **Release Workflow**: If the PR is from a `release/*` branch, additional checks related to the release workflow can be added.

### CD Production Pipeline

- **Build**: Checks out the code, sets up Python 3.8, and installs dependencies.
- **Deploy to Production**: Runs only if the build job succeeds and the triggering workflow completes successfully. Triggers a deployment via a Render Deploy Hook using a secure URL stored in GitHub Secrets.

### CI Workflow

- **Lint**: Checks out the code, sets up Python 3.9, installs dependencies, and runs flake8 to check code style and formatting.
- **Security Scan**: Runs Bandit for security scanning.
- **Build**: Builds the project.
- **Test**: Runs unit tests and optionally uploads test results as artifacts.

### CD Staging Workflow

- **Build Staging**: Checks out the code, sets up Python 3.8, and installs dependencies.
- **Deploy to Staging**: Triggers a deployment via a Render Deploy Hook using a secure URL stored in GitHub Secrets.
- **Integration Test**: Runs integration tests on the deployed staging environment.

### Auto Delete Feature Branch

- **Delete Branch**: Runs only if the pull request is merged and the branch name starts with `feature/`. Deletes the feature branch from the repository.

### Release Please

- **Release**: Checks out the code, sets up Node.js, and runs the release-please action to create a release.

By following these guidelines, you can help ensure a smooth and consistent workflow for all contributors. Thank you for your contributions!

This `CONTRIBUTING.md` file provides a comprehensive overview of the rules and guidelines for contributing to your project, including the branching strategy, commit message format, local development setup, and CI/CD pipeline rules.