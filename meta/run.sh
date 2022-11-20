#!/usr/bin/env bash

set -e

run_client() {
    exec $GODOT_PATH --verbose systems/world/world.tscn 
}

run_server() {
		exec $GODOT_PATH --headless misc/run_server.tscn 
}

if [ "$1" == "client" ]; then
    run_client
elif [ "$1" == "server" ]; then
    run_server
else
    echo "Use ./meta/run.sh client or ./meta/run.sh server"
fi
