# espinet

compose setup for my homelab, mostly focused on multimedia and archival

## setup

wip

- create your environment variable file in `.env` and follow the documentation inside of `compose.yml`
- run `bash ./scripts/setup.sh`

## services

- caddy: reverse proxying
- gluetun: vpn for torrenting
- qbittorrent: bittorrent client
- qbittorrent-natmap: auto port forwarding
- jellyfin: media server for anime/tv/movies
- navidrome: media server for music
- cloudflare-ddns: keep A/AAAA records up to date
- deemix: music downloader

## license

[zlib/libpng](LICENSE.md)
