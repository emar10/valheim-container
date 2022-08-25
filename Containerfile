# Valheim Dedicated Server, Containerized

FROM docker.io/steamcmd/steamcmd:ubuntu

LABEL maintainer="ethan@emar10.dev"

ENV PUID 1000
ENV PGID ${PUID}

# Grab additional dependencies
RUN apt-get update; \
    apt-get install -y gosu; \
    rm -rf /var/lib/apt/lists/*

# Create valheim user
RUN useradd --uid 1000 \
            --shell /bin/nologin \
            --home /home/valheim \
            --create-home \
            valheim

# Run steamcmd
RUN gosu valheim steamcmd +exit

# Create directories
RUN mkdir /config \
          /gamedata

# Copy over scripts
ADD entrypoint.sh /entrypoint.sh
ADD run_valheim.sh /run_valheim.sh
RUN chmod +x /entrypoint.sh /run_valheim.sh

# Environment variables
ENV VALHEIM_SERVER_NAME="My Valheim Server" \
    VALHEIM_WORLD_NAME="world" \
    VALHEIM_PORT="2456" \
    VALHEIM_PASSWORD="youshouldprobablychangethis"

# Expose default ports and volumes
EXPOSE 2456-2458/udp

VOLUME [ "/config", "/gamedata" ]

STOPSIGNAL SIGINT
ENTRYPOINT [ "/entrypoint.sh" ]

