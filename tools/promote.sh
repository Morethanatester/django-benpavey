#!/bin/bash

set -e

ENVIRONMENT=$1

# Use environment variables for GitHub credentials
git config --global user.email "$GH_EMAIL"
git config --global user.name "$GH_USERNAME"

# Stash any local changes
git stash

if [ "$ENVIRONMENT" == "dev" ]; then
  echo "Promoting code to the Dev environment. Deployment in progress..."
  git fetch origin
  git checkout dev || git checkout -b dev
  git pull origin dev
  git merge --no-ff --allow-unrelated-histories $(git rev-parse --abbrev-ref @{-1})
  git push origin dev
elif [ "$ENVIRONMENT" == "pre-prod" ]; then
  echo "Promoting code to the Pre-Prod environment. Deployment in progress..."
  git fetch origin
  git checkout pre-prod || git checkout -b pre-prod
  git pull origin pre-prod
  git merge --no-ff --allow-unrelated-histories dev
  git push origin pre-prod
elif [ "$ENVIRONMENT" == "main" ]; then
  echo "Promoting code to the Main environment. Deployment in progress..."
  git fetch origin
  git checkout main
  git pull origin main
  git merge --no-ff --allow-unrelated-histories pre-prod
  git push origin main
else
  echo "Unknown environment: $ENVIRONMENT"
  exit 1
fi

# Apply stashed changes if any
git stash pop || true