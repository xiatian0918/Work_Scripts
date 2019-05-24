#!/bin/sh


/usr/bin/redis-cli -h 192.168.0.63 -p 6379 --raw<<EOF
KEYS cele*
EOF
