#!/bin/bash

pullAll()
{
    local BRANCH=${1}
    for item in *; do
        if [ -d $item ]; then
            echo "--- Repository: ${item} Branch: ${BRANCH}"
            cd $item
            git checkout ${BRANCH}
            git pull
            cd ..
        fi
    done
}

if [ 1 -ne $# ]; then
    echo "Need branch argument: $(basename $0) [sumo|zeus]"
    exit 1
else
    BRANCH=${1}
    echo "--- Branch: ${BRANCH}"
fi

REPOSITORIES_INTERNET=('git://git.yoctoproject.org/poky' 'git://git.openembedded.org/meta-openembedded' 'git://github.com/meta-qt5/meta-qt5.git' 'https://git.yoctoproject.org/git/meta-freescale')
REPOSITORIES_CUSTOM=('https://github.com/IlyaKyznetsov/meta-ik.git')

DIR='internet'
if [ ! -d ${DIR} ]; then
    mkdir ${DIR}
    cd ${DIR}
    for item in ${REPOSITORIES_INTERNET[*]}; do
        git clone -b ${BRANCH} $item
    done
    cd ..
else
    cd ${DIR}
    pullAll ${BRANCH}
    cd ..
fi

DIR='custom'
if [ ! -d ${DIR} ]; then
    mkdir ${DIR}
    cd ${DIR}
    for item in ${REPOSITORIES_CUSTOM[*]}; do
        git clone -b ${BRANCH} $item
    done
    cd ..
else
    cd ${DIR}
    pullAll ${BRANCH}
    cd ..
fi
