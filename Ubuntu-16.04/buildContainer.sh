CONTAINER_NAME='ubuntu-yocto-build-16.04'
CONTAINER_USER='build'
BIN='docker'
#BIN='podman'
#if [[ ${BIN}=='podman' ]]; then
#CONTAINER_USER_LOCAL_HOME="$CURRENT_DIR/../${CONTAINER_NAME}"
#if [ ! -d "${CONTAINER_USER_LOCAL_HOME}" ]; then
#    mkdir -p "${CONTAINER_USER_LOCAL_HOME}"
#fi
#podman unshare chown -R $(id -u) "${CONTAINER_USER_LOCAL_HOME}"
#fi
# sudo usermod --add-subuids 100000-165536 $USER
# sudo usermod --add-subgids 100000-165536 $USER
#${BIN} build --no-cache --build-arg "host_uid=689824" --build-arg "host_gid=689824" --build-arg "USER_NAME=$CONTAINER_USER" -t "${CONTAINER_NAME}" .
${BIN} build --no-cache --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --build-arg "USER_NAME=$CONTAINER_USER" -t "${CONTAINER_NAME}" .
