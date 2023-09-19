#!/bin/bash

# Check for the required argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <port-number>"
    exit 1
fi

PORT=$1

# Find the process ID
PID=$(lsof -ti tcp:$PORT)

if [ -z "$PID" ]; then
    echo "No process found listening on port $PORT"
    exit 0
fi

# Kill the process
kill -9 $PID
if [ $? -eq 0 ]; then
    echo "Successfully killed process $PID listening on port $PORT"
else
    echo "Failed to kill process $PID"
fi

