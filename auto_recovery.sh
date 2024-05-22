#!/bin/bash

SERVICES=("service1" "service2" "service3")

is_service_running() {
    if systemctl --quiet is-active $1; then
        echo "$1 is running."
    else
        echo "$1 is not running. Attempting to restart..."
        restart_service $1
    fi
}

restart_service() {
    systemctl start $1
    if systemctl --quiet is-active $1; then
        echo "$1 successfully restarted."
    else
        echo "Failed to restart $1."
    fi
}

while true; do
    for service in ${SERVICES[@]}; do
        is_service_running $service
    done
    sleep 60
done
