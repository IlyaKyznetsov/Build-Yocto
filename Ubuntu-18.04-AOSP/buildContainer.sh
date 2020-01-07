CONTAINER_NAME='ubuntu-aosp-build-18.04'
CONTAINER_USER='build'
BIN='docker'
# BIN='podman'
# sudo usermod --add-subuids 100000-165536 $USER
# sudo usermod --add-subgids 100000-165536 $USER
${BIN} build --no-cache --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --build-arg "USER_NAME=$CONTAINER_USER" -t "${CONTAINER_NAME}" .
