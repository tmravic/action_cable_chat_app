#!/bin/bash
rm -f tmp/pids/server.pid
exec rails server -b '0.0.0.0'
