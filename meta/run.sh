#!/usr/bin/env bash

set -e

run_client() {
    exec $GODOT_PATH main.tscn
}

run_server() {
    echo "TODO"
}

if [ "$1" == "client" ]; then
    run_client
elif [ "$1" == "server" ]; then
    run_server
else
    echo "use ./run.sh client or ./run.sh server"
fi