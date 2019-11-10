#!/usr/bin/env bash
CONTAINER_NAME='ubuntu-yocto-build-16.04'
CONTAINER_USER='build'
CURRENT_DIR="$(dirname $(readlink -f $0))"
BIN='docker'
BIN='podman'
RAM_MEMORY='12288m'
CPU_CORES='1,2,3'
CONTAINER_USER_LOCAL_HOME="$HOME/Media/yocto.git/${CONTAINER_NAME}"
if [ ! -d "${CONTAINER_USER_LOCAL_HOME}" ]; then
    mkdir -p "${CONTAINER_USER_LOCAL_HOME}"
fi
${BIN} run --cpuset-cpus=${CPU_CORES} --memory=${RAM_MEMORY} --user ${CONTAINER_USER} -it -v ${CONTAINER_USER_LOCAL_HOME}:/home/${CONTAINER_USER}:Z ${CONTAINER_NAME} /bin/bash
