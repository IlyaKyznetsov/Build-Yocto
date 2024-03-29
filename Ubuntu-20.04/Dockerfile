# Copyright 2019, Burkhard Stubert (DBA Embedded Use)

# In any directory on the docker host, perform the following actions:
#   * Copy this Dockerfile in the directory.
#   * Create input and output directories: mkdir -p yocto/output yocto/input
#   * Build the Docker image with the following command:
#     docker build --no-cache --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" \
#         --tag "cuteradio-image:latest" .
#   * Run the Docker image, which in turn runs the Yocto and which produces the Linux rootfs,
#     with the following command:
#     docker run -it --rm -v $PWD/yocto/output:/home/cuteradio/yocto/output cuteradio-image:latest

# Use Ubuntu 20.04 LTS as the basis for the Docker image.
FROM ubuntu:20.04

# Install all the Linux packages required for Yocto builds. Note that the packages python3,
# tar, locales and cpio are not listed in the official Yocto documentation. The build, however,
# without them.

# apt-get -y install tzdata && ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && dpkg-reconfigure -f noninteractive tzdata &&
# ENV TZ="Europe/Moscow"
RUN  apt-get -y update && \
     apt-get -y install tzdata && dpkg-reconfigure -f noninteractive tzdata && \
     apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect python3-git python3-jinja2 libegl1-mesa \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales \
     python3-gi python3-click python3-gi-cairo python3-cairo pkg-config libcairo2-dev gcc python3-dev libgirepository1.0-dev \
     vim-tiny mc

# By default, Ubuntu uses dash as an alias for sh. Dash does not support the source command
# needed for setting up the build environment in CMD. Use bash as an alias for sh.
RUN rm /bin/sh && ln -s bash /bin/sh
RUN ln -s /usr/bin/vim.tiny /usr/bin/vim

# Set the locale to en_US.UTF-8, because the Yocto build fails without any locale set.
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

#ENV USER_NAME build
ARG USER_NAME=build
ENV PROJECT build

# The running container writes all the build artefacts to a host directory (outside the container).
# The container can only write files to host directories, if it uses the same user ID and
# group ID owning the host directories. The host_uid and group_uid are passed to the docker build
# command with the --build-arg option. By default, they are both 1001. The docker image creates
# a group with host_gid and a user with host_uid and adds the user to the group. The symbolic
# name of the group and user is cuteradio.
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

# Perform the Yocto build as user cuteradio (not as root).
# NOTE: The USER command does not set the environment variable HOME.

# By default, docker runs as root. However, Yocto builds should not be run as root, but as a 
# normal user. Hence, we switch to the newly created user cuteradio.
USER $USER_NAME

# Create the directory structure for the Yocto build in the container. The lowest two directory
# levels must be the same as on the host.
#ENV BUILD_INPUT_DIR /home/$USER_NAME/yocto/input
#ENV BUILD_OUTPUT_DIR /home/$USER_NAME/yocto/output
#RUN mkdir -p $BUILD_INPUT_DIR $BUILD_OUTPUT_DIR

# Clone the repositories of the meta layers into the directory $BUILD_INPUT_DIR/sources/cuteradio.
#WORKDIR $BUILD_INPUT_DIR
#RUN git clone --recurse-submodules https://github.com/bstubert/$PROJECT.git

# Prepare Yocto's build environment. If TEMPLATECONF is set, the script oe-init-build-env will
# install the customised files bblayers.conf and local.conf. This script initialises the Yocto
# build environment. The bitbake command builds the rootfs for our embedded device.
#WORKDIR $BUILD_OUTPUT_DIR
#ENV TEMPLATECONF=$BUILD_INPUT_DIR/$PROJECT/sources/meta-$PROJECT/custom
#CMD source $BUILD_INPUT_DIR/$PROJECT/sources/poky/oe-init-build-env build \
#    && bitbake $PROJECT-image

# Make /home/build the working directory 
WORKDIR /home/$USER_NAME

