#!/bin/bash

function start() {
    for i in 1 2 3 4 5
    do
        echo "start jepsen db node $i"
        docker ps -a | grep -qw jepsen_n$i || \
        docker run -d --privileged --name jepsen_n$i -e ROOT_PASS="root" siddontang/jepsen_db /run.sh

        # if jepsen is not running, start it. 
        docker ps | grep -qw jepsen_n$i || docker start jepsen_n$i
    done 

    echo "start jepsen control node"

    if ! docker ps -a | grep -qw jepsen_control; then
        docker run -t -i --privileged --name jepsen_control \
        --link jepsen_n1:n1 --link jepsen_n2:n2 --link jepsen_n3:n3 \
        --link jepsen_n4:n4 --link jepsen_n5:n5 -v $(pwd):/jepsen_dev siddontang/jepsen_control
    else
        docker ps | grep -qw jepsen_control || docker start jepsen_control
        docker exec -t -i jepsen_control /bin/bash
    fi
}

function stop() {
    for i in 1 2 3 4 5
    do
        echo "stop jepsen db node $i" 
        docker stop jepsen_n$i
    done

    echo "stop jepsen control node"
    docker stop jepsen_control
}

function pull() {
    echo "pull jepsen db node"
    docker pull siddontang/jepsen_db
    echo "pull jepsen control node"
    docker pull siddontang/jepsen_control
}

function remove() {
    for i in 1 2 3 4 5
    do
        echo "remove jepsen db node $i" 
        docker rm -f jepsen_n$i
    done

    echo "remove jepsen control node"
    docker rm -f jepsen_control
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
        pull
    ;;
    "remove")
        remove
    ;;
    "help")
        echo "run_multi.sh [start|stop|restart|remove|pull]"
    ;;
    *) 
        start
    ;;
esac