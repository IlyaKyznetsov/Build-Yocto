NAME='ubuntu-yocto-build-16.04'
USER='build'
docker build --no-cache --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --build-arg "USER_NAME=$USER" -t "${NAME}" .
