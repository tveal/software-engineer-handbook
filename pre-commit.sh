#!/bin/bash

set -e

unstagedMdCount=$(git status --porcelain | grep '^.M\|^??' | grep '.*\.md$' | wc -l)
if [ "$unstagedMdCount" -gt "0" ]; then
    echo
    echo "FAILED to commit; you have $unstagedMdCount unstaged doc files (*.md)"
    echo
    exit 1
fi
