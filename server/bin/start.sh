#!/usr/bin/env bash
puma -e production -p 443 --pidfile tmp/pids/puma.pid -d
