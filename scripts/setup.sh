#!/bin/bash

# Creates volumes
docker volume create postgresql-volume
docker volume create redis-volume
docker volume create nginx-volume
docker volume create letsencrypt-volume
docker volume create nextcloud-aio-volume
docker volume create searxng-volume
docker volume create homepage-volume
docker volume create qbittorrentvpn-volume
docker volume create radarr-volume
docker volume create sonarr-volume
docker volume create prowlarr-volume
docker volume create readarr-volume
docker volume create recyclarr-volume
docker volume create jellyfin-volume
docker volume create deemix-volume

# Creates network
docker network create global-network
docker network create download-network
