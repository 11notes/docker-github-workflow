# 🏔️ Alpine Linux
${{ SHIELDS }}

${{ CONTENT:SYNOPSIS }} This image will give you a base Alpine image with some additional tweaks like some bin’s which are present by default and the mimalloc memory allocator which can be used for certain apps to deal with musl’s not so optimized malloc for multi threading. 

${{ CONTENT:COMPOSE }}

${{ CONTENT:DEFAULTS }}

${{ CONTENT:ENVIRONMENT }}
| `LD_PRELOAD` | Set mimalloc as default memalloc | /lib/libmimalloc.so |
| `MIMALLOC_LARGE_OS_PAGES` | Large memory pages by default | 1 |

${{ CONTENT:SOURCE }}

${{ TITLE:BUILT }}
* [mimalloc](https://github.com/microsoft/mimalloc)
* [alpine](https://alpinelinux.org)

${{ CONTENT:TIPS }}