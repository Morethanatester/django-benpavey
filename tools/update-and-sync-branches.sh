#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to handle errors
error_handler() {
    echo "Error occurred in script at line: $1"
    exit 1
}

# Trap errors and call error_handler
trap 'error_handler $LINENO' ERR

# Check for unstaged changes
if [[ -n $(git status -s) ]]; then
    echo "You have unstaged changes. Please commit or stash them before running this script."
    exit 1
fi

echo "Fetching all branches from the remote repository..."
git fetch --all

echo "Switching to the dev branch and pulling the latest changes from main..."
git checkout dev
git pull origin dev
git pull origin main
git rebase origin/dev

echo "Pushing local changes to the remote dev branch..."
git push origin dev --force-with-lease

echo "Switching to the pre-prod branch and pulling the latest changes from main..."
git checkout pre-prod
git pull origin pre-prod
git pull origin main
git rebase origin/pre-prod

echo "Pushing local changes to the remote pre-prod branch..."
git push origin pre-prod --force-with-lease

echo "Switching to the main branch and pulling the latest changes..."
git checkout main
git pull origin main
git rebase origin/main

echo "Pushing local changes to the remote main branch..."
git push origin main --force-with-lease

echo "Switching back to the dev branch..."
git checkout dev

echo "Branches have been successfully updated and synchronized."