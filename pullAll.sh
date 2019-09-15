#!/usr/bin/env bash
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "--- $BRANCH ---"
for item in *; do
    if [ -d $item ]; then
        echo $item
        cd $item
        git checkout $BRANCH
        git pull
	cd ..
    fi
done
