#!/bin/bash
BIN='docker'
BIN='podman'
# Stop all containers
${BIN} stop $(${BIN} ps -aq)
# Delete all containers
${BIN} rm $(${BIN} ps -aq)
# Delete all images
${BIN} rmi $(${BIN} images -q)
