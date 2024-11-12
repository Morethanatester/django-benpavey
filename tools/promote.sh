#!/bin/bash

set -e

ENVIRONMENT=$1

# Set up Git configuration
git config --global user.email "$GH_EMAIL"
git config --global user.name "$GH_USERNAME"

# Authenticate with GitHub token
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

# Ensure the working directory is clean
if ! git diff --exit-code && git diff --cached --exit-code; then
  echo "Error: Unstaged changes detected. Ensure branches are up-to-date and clean."
  exit 1
fi

# Promotion logic based on environment
case "$ENVIRONMENT" in
  "feature-to-dev")
    echo "Promoting feature branch to the Dev environment..."
    FEATURE_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git fetch origin dev
    git checkout dev
    git pull origin dev
    # Squash merge to consolidate feature branch changes
    git merge --squash "$FEATURE_BRANCH"
    git commit -m "Promote feature branch to dev with squashed changes"
    git push origin dev
    ;;
  
  "pre-prod")
    echo "Promoting code to the Pre-Prod environment..."
    git fetch origin pre-prod
    git checkout pre-prod
    git pull origin pre-prod
    # Squash merge to consolidate dev branch changes
    git merge --squash dev
    git commit -m "Promote dev to pre-prod with squashed changes"
    git push origin pre-prod
    ;;

  "main")
    echo "Promoting code to the Main environment..."
    git fetch origin main
    git checkout main
    git pull origin main
    # Squash merge to consolidate pre-prod branch changes
    git merge --squash pre-prod
    git commit -m "Promote pre-prod to main with squashed changes"
    git push origin main
    ;;
  
  *)
    echo "Unknown environment: $ENVIRONMENT"
    exit 1
    ;;
esac
