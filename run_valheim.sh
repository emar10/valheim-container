#!/bin/bash
# Valheim Update/Run script

set -e

echo Installing/Updating Valheim...
${STEAMCMDDIR}/steamcmd.sh +@ShutdownOnFailedCommand 1 \
  +force_install_dir /gamedata \
  +login anonymous \
  +app_update 896660 validate \
  +quit

# Set up library paths
cd /gamedata
export LD_LIBRARY_PATH=/gamedata/linux64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export SteamAppId=892970

exec /gamedata/valheim_server.x86_64 -nographics -batchmode \
  -name "${VALHEIM_SERVER_NAME}" \
  -port "${VALHEIM_PORT}" \
  -world "${VALHEIM_WORLD_NAME}" \
  -password "${VALHEIM_PASSWORD}" \
  -savedir /config
