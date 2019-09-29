#!/usr/bin/env bash
CURRENT_DIR="$(dirname $(readlink -f $0))"
NAME='ubuntu-yocto-build-16.04'
USER='build'
DIR='Media/yocto'
RAM_MEMORY='12288m'
CPU_CORES='1,2,3'
LOCAL_PATH="$CURRENT_DIR/../$NAME"
if [ ! -d "${LOCAL_PATH}" ]; then
    mkdir -p "${LOCAL_PATH}"
fi
#docker run --user ${USER} --privileged -it -v ${LOCAL_PATH}:/home/${NAME} ${NAME} /bin/bash
docker run --cpuset-cpus=${CPU_CORES} --memory=${RAM_MEMORY} --user ${USER} -it -v ${LOCAL_PATH}:/home/${USER}:Z ${NAME} /bin/bash
