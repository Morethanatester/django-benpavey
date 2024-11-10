#!/bin/bash

set -e

ENVIRONMENT=$1

# Set up Git configuration
git config --global user.email "$GH_EMAIL"
git config --global user.name "$GH_USERNAME"

# Ensure the working directory is clean
if ! git diff --exit-code && git diff --cached --exit-code; then
  echo "Error: Unstaged changes detected. Ensure branches are up-to-date and clean."
  exit 1
fi

# Promotion logic based on environment
case "$ENVIRONMENT" in
  "dev")
    echo "Promoting code to the Dev environment..."
    git fetch origin
    git checkout dev
    git pull origin dev
    git merge --no-ff --no-edit $(git rev-parse --abbrev-ref @{-1})
    git push origin dev
    ;;
  "pre-prod")
    echo "Promoting code to the Pre-Prod environment..."
    git fetch origin
    git checkout pre-prod
    git pull origin pre-prod
    git merge --no-ff --no-edit dev
    git push origin pre-prod
    ;;
  "main")
    echo "Promoting code to the Main environment..."
    git fetch origin
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
