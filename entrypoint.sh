#!/bin/bash
# Valheim Container Entrypoint

set -e

echo Setting up UID/GID ${PUID}/${PGID}...
groupmod --gid ${PGID} steam
usermod --uid ${PUID} steam
chown -R steam:steam /gamedata /config /home/steam

echo Setup finished, starting server...
exec gosu steam /run_valheim.sh
