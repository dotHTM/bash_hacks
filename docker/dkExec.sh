#!/usr/bin/env bash
# dkExec.sh

DOCKER_CMD='docker'
CONTAINER_NAME=$1 && shift
LSP_CMD=$1 && shift

if [[ -z `which "${DOCKER_CMD}"` ]]; then
    echo "Trouble finding '"${DOCKER_CMD}"' exec."
    exit
fi

if [[ -z `"${DOCKER_CMD}" ps | grep "${CONTAINER_NAME}"` ]]; then
    echo "Is the container '${CONTAINER_NAME}' running?"
    "${DOCKER_CMD}" ps
    exit
fi

which_lsp=`"${DOCKER_CMD}" exec -i "${CONTAINER_NAME}" which "${LSP_CMD}"`
# echo "which_lsp     : ''${which_lsp}''"
env_lsp=`"${DOCKER_CMD}" exec -i "${CONTAINER_NAME}" /usr/bin/env "${LSP_CMD}"`
# echo "env_lsp       : ''${env_lsp}''"

if [[ \
    -z `"${DOCKER_CMD}" exec -i "${CONTAINER_NAME}" which "${LSP_CMD}"` || \
    -z `"${DOCKER_CMD}" exec -i "${CONTAINER_NAME}" /usr/bin/env "${LSP_CMD}"` \
    ]]; then
    echo "Trouble finding '${LSP_CMD}' exec inside docker container."
    exit
fi

"${DOCKER_CMD}" \
    exec -i \
    "${CONTAINER_NAME}" \
    "${LSP_CMD}"

sleep 10
