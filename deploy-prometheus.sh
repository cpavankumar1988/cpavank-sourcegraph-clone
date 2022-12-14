#!/usr/bin/env bash
set -e

# Description: Prometheus collects metrics and aggregates them into graphs.
#
# Disk: 200GB / persistent SSD
# Network: 100mbps
# Liveness probe: n/a
# Ports exposed to other Sourcegraph services: none
# Ports exposed to the public internet: none (HTTP 9090 should be exposed to admins only)
#
docker run --detach \
    --name=prometheus \
    --network=sourcegraph \
    --restart=always \
    --cpus=4 \
    --memory=8g \
    -p 0.0.0.0:9090:9090 \
    -v ~/sourcegraph-docker/prometheus-disk:/prometheus-data \
    -v $(pwd)/prometheus:/etc/prometheus \
    sourcegraph/prometheus:v1.4.1@sha256:1a02878ac9a0f532a68673bda93d406b21786706446c42a40cb3ed3e867278c0 \
    -config.file=/etc/prometheus/prometheus.yml \
    -storage.local.path=/prometheus-data \
    -web.console.libraries=/etc/prometheus/console_libraries \
    -web.console.templates=/etc/prometheus/consoles
