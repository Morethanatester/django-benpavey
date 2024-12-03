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

# Check if the current branch is a feature branch
current_branch=$(git symbolic-ref --short HEAD)
if [[ $current_branch == feature/* ]]; then
    echo "You are currently on a feature branch ($current_branch)."
    echo "Please switch to another branch, or push changes and delete the branch before running this script."
    exit 1
fi

# Fetch all branches and prune deleted ones
echo "Fetching and pruning branches from the remote repository..."
git fetch --all --prune

# Switch to the main branch
echo "Switching to the main branch..."
git checkout main

# Pull the latest changes from main
echo "Pulling the latest changes from origin/main..."
git pull origin main

# Pull the latest changes from development (if it exists)
if git show-ref --verify --quiet refs/heads/development; then
    echo "Pulling the latest changes from origin/development..."
    git checkout development
    git pull origin development
else
    echo "Development branch does not exist locally or remotely. Skipping."
fi

# Switch back to the main branch
echo "Switching back to the main branch..."
git checkout main

# Delete all local feature branches
echo "Deleting all local feature branches..."
for branch in $(git branch --list 'feature/*'); do
    if git show-ref --verify --quiet refs/heads/"$branch"; then
        echo "Deleting branch: $branch"
        git branch -D "$branch"
    else
        echo "Branch $branch no longer exists. Skipping."
    fi
done

# Push local changes to the remote main branch
echo "Pushing local changes to the remote main branch..."
git push origin main

# Switch back to the development branch (if it exists)
if git show-ref --verify --quiet refs/heads/development; then
    echo "Switching back to the development branch..."
    git checkout development
fi

echo "Branches have been successfully updated and synchronized."
