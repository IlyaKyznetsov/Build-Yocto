#!/bin/bash

allClonePull()
{
    local CURRENT_DIR="${PWD}"
    local PATH_TO_CLONE_DIR="${1}"
    local BRANCH="${2}"
    local REPOSITORIES="${*:3}"
    echo "--- Clone/pull to: ${PATH_TO_CLONE_DIR}"
    echo "--- Repositories: ${REPOSITORIES[*]}"
    echo "--- Set branch: ${BRANCH}"
    if [ ! -d ${PATH_TO_CLONE_DIR} ]; then
        mkdir -p ${PATH_TO_CLONE_DIR}
    fi
    cd ${PATH_TO_CLONE_DIR}
    for item in ${REPOSITORIES[*]}; do
        echo "--- Repository: ${item} Branch: ${BRANCH}"
        DIR="$(basename $item)"
	[[ 'git' == "${DIR##*.}" ]] && DIR="${DIR%.*}"
        if [ ! -d ${DIR}/.git ]; then
            git clone -b ${BRANCH} $item
        else
            cd $DIR
            git checkout ${BRANCH}
            git pull
            cd ..
        fi
    done
    cd "${CURRENT_DIR}"
}

if [ 1 -ne $# ]; then
    echo "Need branch argument: $(basename $0) [sumo|zeus]"
    exit 1
else
    BRANCH=${1}
    echo "--- Branch: ${BRANCH}"
fi

REPOSITORIES_INTERNET=('git://git.yoctoproject.org/poky' 'git://git.openembedded.org/meta-openembedded' 'git://github.com/meta-qt5/meta-qt5.git' 'https://git.yoctoproject.org/git/meta-freescale' 'git://git.yoctoproject.org/meta-xilinx')
REPOSITORIES_CUSTOM=('https://github.com/IlyaKyznetsov/meta-ik.git')

allClonePull 'internet' ${BRANCH} ${REPOSITORIES_INTERNET[*]}
allClonePull 'custom' master ${REPOSITORIES_CUSTOM[*]}
