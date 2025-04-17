#!/bin/bash

# 终止监听端口号 5001 的进程
if lsof -ti :5001; then
    kill $(lsof -ti :5001)
    echo "Killed process listening on port 5001"
else
    echo "No process found listening on port 5001"
fi

# 终止监听端口号 3 的进程
if lsof -ti :3; then
    kill $(lsof -ti :3)
    echo "Killed process listening on port 3"
else
    echo "No process found listening on port 3"
fi
