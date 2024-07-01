#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $ sh $0 <backup-remote-url> <repo-path>"
    exit 1
fi

backup_remote_url="$1"
repoPath="$2"

addBackupRemote() {
    cd $repoPath || exit

    for dir in */ ; do
        if [ -d "$dir/.git" ]; then
            cd "$dir" || exit
            dir_name="${dir%/}"

            echo "Adding backup remote... "$backup_remote_url"-"$dir_name".git"
            if git remote | grep -q 'backup'; then
                git remote remove backup
            fi

            git remote add backup "$backup_remote_url"-"$dir_name".git

            cd ..
        else
            echo "Skipping $dir (not a Git repository)"
        fi
    done

    cd ..
}

addBackupRemote
