#!/usr/bin/env bash
BRANCH='warrior'
for item in *; do
    if [ -d $item ]; then
        echo $item
        cd $item
        git checkout $BRANCH
        git pull
	cd ..
    fi
done
