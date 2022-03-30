# Valheim Dedicated Server, Containerized

A no frills container image to run a dedicated server for
[Valheim](https://www.valheimgame.com/). The startup script simply uses
[SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) to install/update
Valheim, then runs the server with options configurable via environment
variables.

Uses [SteamCMD's image](https://github.com/steamcmd/docker) as a base.

## Usage

### Environment Variables

| Variable | Description | Default |
| --- | --- | --- |
| `PUID` | The UID to run as. | `1000` |
| `PGID` | The GID to run as. | `1000` |
| `VALHEIM_SERVER_NAME` | The server's name in the server browser. | `"My Valheim Server"` |
| `VALHEIM_WORLD_NAME` | The world name to generate/use. | `"world"` |
| `VALHEIM_PORT` | The base port to use (see **Ports** below). | `2456` |
| `VALHEIM_PASSWORD` | Password required when joining the server. | `"youshouldprobablychangethis"` |

### Ports

| Default Port Number | Proto | Description |
| --- | --- | --- |
| `2456` | UDP | The main port the server is hosted on. |
| `2457` | UDP | Steam server A2S used to populate info on master servers. |

The main server port is directly controlled by the `VALHEIM_PORT` environment
variable. Valheim Dedicated Server will automatically use this port number + 1
for Steam A2S.

### Volumes

| Mount Point | Description |
| --- | --- |
| `/config` | Persistent server data (admins, bans, worlds, etc.) |
| `/gamedata` | Server package is stored here. Mount this to avoid redownloading the game if the container is recreated. |


## Examples

### CLI

```
$ docker run -d -e VALHEIM_SERVER_NAME="test server" \
                -e VALHEIM_WORLD_NAME="testworld" \
                -e VALHEIM_PASSWORD="greatpassword" \
                -p 2456-2457:2456-2457/udp \
                -v $HOME/valheim/config:/config \
                -v $HOME/valheim/gamedata:/gamedata \
                ghcr.io/emar10/valheim-container:latest
```

### Compose

```yaml
version: '3.9'

services:

    valheim:
        image: ghcr.io/emar10/valheim-container:latest
        restart: always
        environment:
            - "VALHEIM_SERVER_NAME=test server"
            - "VALHEIM_WORLD_NAME=testworld"
            - "VALHEIM_PASSWORD=greatpassword"
        ports:
            - 2456-2457:2456-2457/udp
        volumes:
            - valheim-config:/config
            - valheim-gamedata:/gamedata

volumes:
    valheim-config:
    valheim-gamedata:
```

