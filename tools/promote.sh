#!/bin/bash

set -e

ENVIRONMENT=$1

# Use environment variables for GitHub credentials
git config --global user.email "$GH_EMAIL"
git config --global user.name "$GH_USERNAME"

if [ "$ENVIRONMENT" == "dev" ]; then
  echo "Promoting code to the Dev environment. Deployment in progress..."
  git checkout dev
  git merge --no-ff $(git rev-parse --abbrev-ref HEAD)
  git push origin dev
elif [ "$ENVIRONMENT" == "pre-prod" ]; then
  echo "Promoting code to the Pre-Prod environment. Deployment in progress..."
  git checkout pre-prod
  git merge --no-ff dev
  git push origin pre-prod
elif [ "$ENVIRONMENT" == "main" ]; then
  echo "Promoting code to the Main environment. Deployment in progress..."
  git checkout main
  git merge --no-ff pre-prod
  git push origin main
else
  echo "Unknown environment: $ENVIRONMENT"
  exit 1
fi