#!/bin/bash

# Get the remote URL of the origin
local_git_repo_url=$(git config --get remote.origin.url)

# Print the local Git repository URL
echo "Local Git Repository URL: $local_git_repo_url"
