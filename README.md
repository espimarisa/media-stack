# espinet

compose setup for my homelab, mostly focused on multimedia and archival

## setup

wip

- create your environment variable file in `.env` and follow the documentation inside of `compose.yml`
- run `bash ./scripts/setup.sh`
- todo: guide on how to setup the other services

## services

- caddy: reverse proxying
- gluetun: vpn for torrenting
- qbittorrent: bittorrent client
- qbittorrent-natmap: auto port forwarding
- jellyfin: media server for anime/tv/movies
- navidrome: media server for music
- cloudflare-ddns: keep A/AAAA records up to date
- deemix: music downloader via grabbing from deemix
- lidarr: music pvr used in combination with deemix
- radarr: movies pvr
- sonarr: tv/anime pvr

## license

[zlib/libpng](LICENSE.md)
