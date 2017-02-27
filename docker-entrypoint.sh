#!/bin/bash
set -e

case "$1" in 
	dump)
		shift
		exec /usr/bin/python -u /app/ldapdump.py
		;;
	ping)
		exec /bin/ping -c 4 8.8.8.8
		;;
esac

exec "$@"
