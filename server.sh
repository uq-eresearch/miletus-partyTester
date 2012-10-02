#!/bin/sh
#
# Starting and stopping the Rails server.
#
# Copyright (C) 2012, The University of Queensland.
#----------------------------------------------------------------

PIDFILE=tmp/pids/server.pid

if [ $# -eq 0 ]; then
    echo "Usage: $0 command"
    echo "Commands:"
    echo "  start   - starts the server"
    echo "  stop    - stops the server"
    echo "  restart - stops and starts the server"
    echo "  status  - shows the status of the server"

elif [ $# -eq 1 ]; then

    if [ ! -d `dirname $PIDFILE` ]; then
	echo "Error: current directory is not the project root directory"
	exit 1
    fi

    case "$1" in
	start)
	    if [ -f $PIDFILE ]; then
		echo "Error: PID file found: server already running?"
		exit 1
	    else
		rails server -d
	    fi
	    ;;

	stop)
	    if [ -f $PIDFILE ]; then
		kill -INT `cat tmp/pids/server.pid`
	    else
		echo "Warning: PID file not found: server not running?"
	    fi
	    ;;
	restart)
	    if [ -f $PIDFILE ]; then
		kill -INT `cat tmp/pids/server.pid`
		sleep 1
		while [ -f $PIDFILE ]; do
		    echo "Waiting for server to stop"
		    sleep 1
		done
		rails server -d

	    else
		echo "Warning: PID file not found: server not running?"
	    fi
	    ;;

	status)
	    if [ -f $PIDFILE ]; then
		echo "Server running"
	    else
		echo "Server stopped"
	    fi
	    ;;
	*)
	    echo "Usage error: unknown command: $1" >&2
	    exit 2
    esac

else
  echo "Usage error: too many arguments" >&2
  exit 2
fi

exit 0

#EOF
