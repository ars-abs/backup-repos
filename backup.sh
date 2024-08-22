#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $ sh $0 <repo-path>"
    exit 1
fi

# eval "$(ssh-agent -s)"
# echo <passphrase> | ssh-add ~/.ssh/id_rsa

cd "$1"

for dir in */ ; do
    if [ -d "$dir/.git" ]; then
        echo "Processing repository: $dir"
        cd "$dir" || exit

        echo "Pulling the latest changes from remote origin..."
        git fetch origin --tags

        echo "Pushing changes to backup remote..."
        git push backup refs/remotes/origin/*:refs/heads/*
        git push backup --tags

        cd ..
    else
        echo "Skipping $dir (not a Git repository)"
    fi
done
