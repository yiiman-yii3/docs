#!/bin/bash

# Specify the directory where repositories will be cloned
TARGET_DIR="./../related_packages/"

# Check if the directory exists, if not, create it
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

# Read and decode JSON into an array
REPOSITORIES=($(jq -r '.[]' repositories.json))

# Clone each repository in the array
for repo in "${REPOSITORIES[@]}"; do
    echo "Cloning $repo"
    git clone "$repo" "$TARGET_DIR/$(basename "$repo" .git)"
done

echo "All repositories cloned to $TARGET_DIR"
