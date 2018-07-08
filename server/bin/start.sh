#!/usr/bin/env bash
mkdir -p tmp/pids
puma -e production -p 443 --pidfile tmp/pids/puma.pid -d
