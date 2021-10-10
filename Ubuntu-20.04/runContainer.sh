#!/usr/bin/env bash
CONTAINER_NAME='ubuntu-yocto-build-20.04'
CONTAINER_USER='build'
CURRENT_DIR="$(dirname $(readlink -f $0))"
BIN='docker'
#BIN='podman'
RAM_MEMORY='6144m'
CPU_CORES='1,2,3'
CONTAINER_USER_LOCAL_HOME="$CURRENT_DIR/../build-yocto-ubuntu-20.04"
if [ ! -d "${CONTAINER_USER_LOCAL_HOME}" ]; then
    mkdir -p "${CONTAINER_USER_LOCAL_HOME}"
fi
echo "$CONTAINER_USER_LOCAL_HOME"

if [[ ${BIN} == 'docker' ]]; then
    ${BIN} run --memory-swappiness=0 --cpuset-cpus=${CPU_CORES} --user ${CONTAINER_USER} -it -v ${CONTAINER_USER_LOCAL_HOME}:/home/${CONTAINER_USER}:Z ${CONTAINER_NAME} /bin/bash
elif [[ ${BIN} == 'podman' ]]; then
    ${BIN} run --memory-swappiness=0 --cpuset-cpus==${CPU_CORES} --memory=${RAM_MEMORY} -userns-uid-map-user=user ${USER} -it -v ${CONTAINER_USER_LOCAL_HOME}:/home/${CONTAINER_USER}:Z ${CONTAINER_NAME} /bin/bash
fi
