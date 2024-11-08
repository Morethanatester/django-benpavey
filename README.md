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

## Making Changes Locally

Before starting new changes, always ensure your `dev` and `pre-prod` branches are up-to-date with the latest changes from `main`:

```sh
./tools/update-and-sync-branches.sh
```

This command will:

- Fetch all branches from the remote.
- Switch to the `dev` branch and pull the latest changes from `dev`, `main`, and `pre-prod`.
- Push any local changes to the remote `dev` branch.
- Switch to the `pre-prod` branch and pull the latest changes from `pre-prod` and `main`.
- Push any local changes to the remote `pre-prod` branch.
- Switch back to the `dev` branch.

### Create a New Branch
To create a new branch from the `main` branch, use the following command:

```sh
git checkout -b <feature-name> main
```

Replace `<feature-name>` with a descriptive name for your branch.

### Make Your Changes

Make your changes in the new branch.

### Commit Your Changes

Commit your changes with a meaningful commit message following Conventional Commits:

```sh
git add .
git commit -m "feat: add new feature"
```

### Commit Frequency

Commit your changes frequently to keep your work manageable and to make it easier to track progress. Ideally, commit:

- After completing a small, logical piece of work.
- When you reach a significant milestone.
- Before starting a new task or feature.
- When you have made changes that you want to save and share with others.

Frequent commits help in maintaining a clear project history and facilitate easier collaboration.

### Push Your Changes

Push your changes to the remote repository:

```sh
git push origin <feature-name>
```

Replace `<feature-name>` with the name of your branch.

### Push to Dev

To push your changes to the `dev` branch, use the following command:

```sh
git push origin <feature-name>
```
Replace `<feature-name>` with the name of your branch.

Note: Approval is required for pull requests into the `main` branch, this is built into the CI/CD workflow

---

## Release and Naming Conventions

This project uses release-please to automate versioned releases. Please follow these naming conventions for commits and branches.

### Commit Naming Conventions

We use Conventional Commits to define the release type based on commit messages. Here are the main types:

- **feat**: New features (triggers a minor version update)
    - Example: `feat: add user profile page`
- **fix**: Bug fixes (triggers a patch version update)
    - Example: `fix: correct calculation error`
- **docs**: Documentation-only changes
    - Example: `docs: update README with usage examples`
- **style**: Code style/formatting (non-functional changes)
    - Example: `style: reformat code to meet style guidelines`
- **refactor**: Code restructuring without new features or fixes
    - Example: `refactor: simplify login logic`
- **test**: Adding or updating tests
    - Example: `test: add unit tests for payment processor`
- **chore**: Maintenance tasks (e.g., updating dependencies)
    - Example: `chore: update dependencies`

For breaking changes, append a `!` to the commit type (e.g., `feat!:`) or include `BREAKING CHANGE:` in the commit body. This triggers a major version update.

### Release Triggers

Commits that trigger a release:

- **feat**: Triggers a minor version update.
- **fix**: Triggers a patch version update.
- **feat!** or **BREAKING CHANGE**: Triggers a major version update.

Other commit types (docs, style, refactor, test, chore) do not trigger a release by themselves but are included in the release notes.

---

## Branch Structure

- **dev**: Development branch for testing features and bug fixes.
- **pre-prod**: Staging branch for final testing before production.
- **main**: Production-ready branch where releases are generated.

---

## Release Process

When changes are merged into `main`, release-please automatically:

- Creates a new version tag following Semantic Versioning (MAJOR.MINOR.PATCH).
- Generates release notes based on commit messages.

By following these conventions, you ensure consistent, automated releases. For more information, see [Conventional Commits](https://www.conventionalcommits.org/).

---

## Getting Started

### Prerequisites

- Python 3.9+
- Git

### Setup

Clone the repository:

```sh
git clone https://github.com/morethanatester/django-benpavey.git
cd django-benpavey
```

Create and activate a virtual environment:

```sh
python3 -m venv venv
source venv/bin/activate
```

Install the project dependencies:

```sh
pip install -r requirements.txt
```

Run the Django development server:

```sh
python manage.py runserver
```

---

## Deployment

The project is deployed to Render using separate environments for development and production.

---

## Contributing

Contributions are welcome! Please open an issue or create a pull request with your changes.

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.