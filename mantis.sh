#!/usr/bin/env bash

if [ $# != 1 ]; then
    echo Please call with remote host!
    exit 1
fi


REMOTE=$1
NAME=$USER
LOCAL_SSH_PORT=22
REMOTE_SSH_PORT=22
PORT_FORWARDING_PORT=32222
WORKING_DIRECTORY=$(pwd)
ssh -t $REMOTE -R $PORT_FORWARDING_PORT:localhost:$LOCAL_SSH_PORT \
    'DIR=$(mktemp -d);' \
    'cd $DIR;' \
    'mkdir workspace;' \
    "sshfs -p $PORT_FORWARDING_PORT $USER@localhost:$WORKING_DIRECTORY workspace;" \
    'cd workspace;' \
    'bash;' \
    'cd ../;' \
    'fusermount3 -u workspace;' 
