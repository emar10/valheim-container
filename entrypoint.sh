#!/bin/bash
# Valheim Container Entrypoint

set -e

echo Setting up UID/GID ${PUID}/${PGID}...
groupmod --gid ${PGID} steam
usermod --uid ${PUID} steam
chown -R steam:steam /gamedata /config /home/steam

echo Applying environment settings to the launch script...
sed -i "s/VALHEIM_SERVER_NAME/${VALHEIM_SERVER_NAME}/g" /run_valheim.sh
sed -i "s/VALHEIM_PORT/${VALHEIM_PORT}/g" /run_valheim.sh
sed -i "s/VALHEIM_WORLD_NAME/${VALHEIM_WORLD_NAME}/g" /run_valheim.sh
sed -i "s/VALHEIM_PASSWORD/${VALHEIM_PASSWORD}/g" /run_valheim.sh

set +e

echo Setup finished, starting server...
exec gosu steam /run_valheim.sh
