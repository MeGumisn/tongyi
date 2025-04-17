#!/bin/bash

DIFY_HOME=/home/pw/dify

echo "Starting Dify API service..."
cd "$DIFY_HOME"/api || { echo "Failed to cd to $DIFY_HOME/api"; exit 1; }
nohup poetry run flask run --host 0.0.0.0 --port=5001 > "$DIFY_HOME"/logs/dify_api.log 2>&1 & echo $! > "$DIFY_HOME"/dify_api.pid

echo "Starting Dify Celery worker..."
nohup poetry run celery -A app.celery worker -P gevent -c 1 -Q dataset,generation,mail,ops_trace --loglevel INFO > "$DIFY_HOME"/logs/dify_worker.log 2>&1 & echo $! > "$DIFY_HOME"/dify_worker.pid

echo "Starting Dify Web service..."
cd "$DIFY_HOME"/web || { echo "Failed to cd to $DIFY_HOME/web"; exit 1; }
nohup pnpm start > "$DIFY_HOME"/logs/dify_web.log 2>&1 & echo $! > "$DIFY_HOME"/dify_web.pid
