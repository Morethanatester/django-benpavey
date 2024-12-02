# Ben Pavey's Website - benpavey.com

Welcome to the repository for [benpavey.com](https://benpavey.com). This project is a personal website built using Django and hosted on Render. It includes a structured branching strategy for development and production environments, with automated workflows for deployment.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Development Workflow](#development-workflow)
- [Release and Naming Conventions](#release-and-naming-conventions)
- [Branching Strategy](#branching-strategy)
- [Getting Started](#getting-started)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

---

## Project Overview

This site serves as a personal portfolio to showcase various projects and skills, built with Django and deployed with automated workflows.

---

## Tech Stack

- **Framework**: Django
- **Deployment**: Render
- **CI/CD**: GitHub Actions
- **Versioning**: release-please (planned)

---

## Development Workflow

### Feature Branch Process

1. **Create a Feature Branch**:
   - Create a new branch from `development` for your feature.
   - Use a descriptive name for your branch, e.g., `feature/add-new-feature`.

2. **Make Changes Locally**:
   - Before starting new changes, always ensure your `development` branch is up-to-date with the latest changes from `main`:
     ```sh
     git checkout development
     git pull origin development
     ```

3. **Commit and Push Changes**:
   - Commit your changes to the feature branch and push them to the remote repository:
     ```sh
     git add .
     git commit -m "feat: Add new feature"
     git push origin feature/add-new-feature
     ```

4. **Create a Pull Request to `development`**:
   - Create a pull request (PR) from your feature branch to the `development` branch.
   - This triggers the CI/CD pipeline to run linting, build, and unit tests.
   - If the tests pass, the changes are deployed to the development environment for integration testing.

5. **Integration Testing**:
   - Once the changes are deployed to the development environment, perform integration testing to ensure everything works as expected.

6. **Create a Pull Request to `main`**:
   - After successful integration testing, create a pull request from `development` to `main`.
   - This triggers the CI/CD pipeline to run linting, build, unit tests, and integration tests.
   - If all tests pass, the changes are deployed to the production environment.

### CI/CD Pipeline

The CI/CD pipeline is managed using GitHub Actions and includes the following jobs:

1. **Lint**:
   - Checks code style and formatting using `flake8`.

2. **Build**:
   - Builds the project after the lint job completes successfully.
   - Uses the `SECRET_KEY` and `DATABASE_URL` environment variables from GitHub Secrets.

3. **Test**:
   - Runs unit tests after the build job completes successfully.
   - Uses the `SECRET_KEY` and `DATABASE_URL` environment variables from GitHub Secrets.

4. **Deploy to Development Environment**:
   - Deploys to the development environment when there is a push to the `development` branch or a pull request targeting the `development` branch.
   - Uses the `RENDER_DEV_DEPLOY_HOOK_URL` environment variable from GitHub Secrets.

5. **Integration Test**:
   - Runs integration tests on the deployed development environment.
   - Runs only if the `deploy-dev` job completes successfully.

6. **Deploy to Production Environment**:
   - Deploys to the production environment when there is a push to the `main` branch or a pull request targeting the `main` branch.
   - Uses the `RENDER_PROD_DEPLOY_HOOK_URL` environment variable from GitHub Secrets.

---

## Release and Naming Conventions

- **Feature Branches**: `feature/your-feature-name`
- **Development Branch**: `development`
- **Main Branch**: `main`

### Commit Message Prefixes

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools and libraries such as documentation generation

### Identifying Breaking Changes

- **BREAKING CHANGE**: Include this in the commit message to indicate a breaking change.

Example:
```sh
git commit -m "feat: Add new feature BREAKING CHANGE: This change will break the existing API"