#!/bin/bash

# Ensure the script fails on any error
set -e

# Check if exactly two arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <branchA> <branchB>"
    exit 1
fi

branchA=$1
branchB=release-candidate

# Fetch the latest changes from the remote to ensure we're working with up-to-date information
git fetch --all

# Get all new commits in branchA relative to branchB, excluding merge commits
commits=$(git log $branchB..$branchA --no-merges --pretty=format:"%H" | grep -vE '^Merge branch')

# Checkout to master
git checkout master

# Create a new branch named "hotfix-$branchA"
git checkout -b hotfix-$branchA

# Cherry-pick all the filtered commits
for commit in $commits; do
    git cherry-pick $commit
done

# Push the new branch to the remote repository
git push origin hotfix-$branchA
prcreatem hotfix-$branchA

echo "All operations completed successfully."
