#!/bin/bash

function start() {
    docker run --privileged -t -i -v $(pwd):/jepsen_dev --name jepsen_dind siddontang/jepsen_dind
}

function stop() {
    docker stop jepsen_dind
}

case $1 in 
    "start")
        start
    ;;
    "stop") 
        stop
    ;;
    "restart")
        stop
        start 
    ;;
    "pull") 
        docker pull siddontang/jepsen_dind
    ;;
    "remove")
        docker rm -f jepsen_dind
    ;;
    "help")
        echo "run_multi.sh [start|stop|restart|remove|pull]"
    ;;
    *) 
        start
    ;;
esac
