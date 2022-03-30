#!/bin/bash
# Valheim Update/Run script

set -e

echo Installing/Updating Valheim...
steamcmd +@ShutdownOnFailedCommand 1 \
         +force_install_dir /gamedata \
         +login anonymous \
         +app_update 896660 \
         +exit

# Set up library paths
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/gamedata/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# Set trap to gracefully exit on SIGTERM from the container host
exec /gamedata/valheim_server.x86_64 -name "VALHEIM_SERVER_NAME" \
                                     -port VALHEIM_PORT \
                                     -world "VALHEIM_WORLD_NAME" \
                                     -password "VALHEIM_PASSWORD" \
                                     -savedir /config

# Clean up library path
export LD_LIBRARY_PATH=$templdpath

