#!/usr/bin/env bash
case "$1" in
    start)
        mkdir -p tmp/pids
        rails server -e production
        ;;

    stop)
        kill $(cat tmp/pids/server.pid)
        ;;

    status)
        if [ -e tmp/pids/server.pid ]
        then
            echo "RUNNING"
        else
            echo "STOPPED"
        fi
        ;;

    restart)
        rails restart
        ;;

    setup)
        bundle check
        bundle install
        ;;

    *)
        echo $"Usage: $0 {start|stop|restart|status|setup}"
        exit 1

esac
