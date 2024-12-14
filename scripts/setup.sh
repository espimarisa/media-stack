#!/bin/bash

# Creates volumes
docker volume create caddy-volume
docker volume create qbittorrent-volume
docker volume create seedboxapi-volume
docker volume create gluetun-volume
docker volume create jellyfin-volume
docker volume create navidrome-volume

# Creates network
docker network create global-network
docker network create download-network
