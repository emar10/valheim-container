#!/bin/bash
# Valheim Container Entrypoint

set -e

echo Setting up UID/GID ${PUID}/${PGID}...
groupmod --gid ${PGID} valheim
usermod --uid ${PUID} valheim
chown valheim:valheim /gamedata /config

echo Applying environment settings to the launch script...
sed -i "s/VALHEIM_SERVER_NAME/${VALHEIM_SERVER_NAME}/g" /run_valheim.sh
sed -i "s/VALHEIM_PORT/${VALHEIM_PORT}/g" /run_valheim.sh
sed -i "s/VALHEIM_WORLD_NAME/${VALHEIM_WORLD_NAME}/g" /run_valheim.sh
sed -i "s/VALHEIM_PASSWORD/${VALHEIM_PASSWORD}/g" /run_valheim.sh

set +e

echo Setup finished, starting server...
exec gosu valheim /run_valheim.sh

