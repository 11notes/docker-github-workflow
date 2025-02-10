![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ Alpine Linux
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-github-workflow)![size](https://img.shields.io/docker/image-size/11notes/github-workflow/3.21.2?color=0eb305)![version](https://img.shields.io/docker/v/11notes/github-workflow/3.21.2?color=eb7a09)![pulls](https://img.shields.io/docker/pulls/11notes/github-workflow?color=2b75d6)[<img src="https://img.shields.io/github/issues/11notes/docker-github-workflow?color=7842f5">](https://github.com/11notes/docker-github-workflow/issues)

**Alpine Linux with mimalloc for fastest multi-threaded memory allocation**

# SYNOPSIS 📖
**What can I do with this?** This image will give you a base Alpine image with some additional tweaks like some bin’s which are present by default and the mimalloc memory allocator which can be used for certain apps to deal with musl’s not so optimized malloc for multi threading. 

# COMPOSE ✂️
```yaml
services:
  alpine:
    container_name: "alpine"
    environment:
      TZ: Europe/Zurich
    restart: always
```

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | / | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |
| `LD_PRELOAD` | Set mimalloc as default memalloc | /lib/libmimalloc.so |
| `MIMALLOC_LARGE_OS_PAGES` | Large memory pages by default | 1 |

# SOURCE 💾
* [11notes/github-workflow](https://github.com/11notes/docker-github-workflow)

# BUILT WITH 🧰
* [mimalloc](https://github.com/microsoft/mimalloc)
* [alpine](https://alpinelinux.org)

# GENERAL TIPS 📌
* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services
  
# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-github-workflow/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-github-workflow/issues), thanks. You can find all my repositories on [github](https://github.com/11notes?tab=repositories).