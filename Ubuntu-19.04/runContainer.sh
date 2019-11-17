#!/usr/bin/env bash
CONTAINER_NAME='ubuntu-yocto-build-19.04'
CONTAINER_USER='build'
CURRENT_DIR="$(dirname $(readlink -f $0))"
BIN='docker'
#BIN='podman'
RAM_MEMORY='6144m'
CPU_CORES='1,2,3'
CONTAINER_USER_LOCAL_HOME="$HOME/Media/yocto.git/${CONTAINER_NAME}"
if [ ! -d "${CONTAINER_USER_LOCAL_HOME}" ]; then
    mkdir -p "${CONTAINER_USER_LOCAL_HOME}"
fi
${BIN} run --memory-swappiness=0 --cpuset-cpus=${CPU_CORES} --memory=${RAM_MEMORY} --user ${CONTAINER_USER} -it -v ${CONTAINER_USER_LOCAL_HOME}:/home/${CONTAINER_USER}:Z ${CONTAINER_NAME} /bin/bash
#${BIN} run --memory=6144m --memory-swappiness=0 --cpuset-cpus=0-2 --user ${USER} --privileged -it -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v ${LOCAL_PATH}:/home/${USER} ${NAME} /bin/bash
#${BIN} run --user ${USER} -it -v ${LOCAL_PATH}:/home/${USER}:Z ${NAME} /bin/bash
