#!/bin/bash

set -e

ENVIRONMENT=$1

# Set up Git configuration
git config --global user.email "$GH_EMAIL"
git config --global user.name "$GH_USERNAME"

# Ensure the working directory is clean, ignoring permission changes
if ! git diff --ignore-submodules=all --exit-code && git diff --cached --exit-code; then
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
    git merge --no-ff --no-edit "$FEATURE_BRANCH"
    git push origin dev
    ;;
  
  "pre-prod")
    echo "Promoting code to the Pre-Prod environment..."
    git fetch origin pre-prod
    git checkout pre-prod
    git pull origin pre-prod
    git merge --no-ff --no-edit dev
    git push origin pre-prod
    ;;

  "main")
    echo "Promoting code to the Main environment..."
    git fetch origin main
    git checkout main
    git pull origin main
    git merge --no-ff --no-edit pre-prod
    git push origin main
    ;;
  
  *)
    echo "Unknown environment: $ENVIRONMENT"
    exit 1
    ;;
esac
