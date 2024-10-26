#!/bin/bash

# Creates volumes
docker volume create caddy-volume
docker volume create nextcloud_aio_mastercontainer
docker volume create homarr-volume
docker volume create qbittorrent-volume
docker volume create seedboxapi-volume
docker volume create gluetun-volume
docker volume create radarr-volume
docker volume create sonarr-volume
docker volume create lidarr-volume
docker volume create prowlarr-volume
docker volume create recyclarr-volume
docker volume create jellyfin-volume
docker volume create thelounge-volume
docker volume create deemix-volume

# Creates network
docker network create global-network
