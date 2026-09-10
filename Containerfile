# Valheim Dedicated Server, Containerized

FROM docker.io/cm2network/steamcmd:root-trixie

LABEL maintainer="ethan@emar10.dev"

ENV HOME="${HOMEDIR}"

# Grab additional dependencies
RUN su -s /bin/bash steam -c "${STEAMCMDDIR}/steamcmd.sh +quit"

# Copy over entrypoint
COPY run_valheim.sh /run_valheim.sh
RUN chmod +x /run_valheim.sh

# Environment variables
ENV VALHEIM_SERVER_NAME="My Valheim Server" \
    VALHEIM_WORLD_NAME="world" \
    VALHEIM_PORT="2456" \
    VALHEIM_PASSWORD="youshouldprobablychangethis"

# Expose default ports and volumes
EXPOSE 2456-2458/udp

VOLUME [ "/config", "/gamedata" ]

STOPSIGNAL SIGINT
USER steam
ENTRYPOINT [ "/run_valheim.sh" ]
