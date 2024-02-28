On_Ping_Config:
    type: data
    MOTD: Your npcs are starving!
    VERSION_NAME: Paper!
    ICON: server-icon.png
    PROTOCOL_VERSION: 764
    MAX_PLAYERS: 10
    EXCLUDE_PLAYERS: <server.online_players>
    ALTERNATE_PLAYER_TEXT: <empty>

On_Connection_Logging:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - The server appears offline untill you join the server. This is for connection loggers that check if the server is running.
        - Your Ip address is associated with your UUID and your UUID is associated with your IP address.
    events:
        on server list ping:
        - define id <server.flag[joined.<context.address>].deduplicate.parse[name].formatted||<context.address>>
        - announce "[<element[server ping].color[yellow]>] [<element[Protocol].color[blue]>: <context.protocol_version>] [<element[client_version].color[blue]>: <context.client_protocol_version||None>] Names from adress: <[id].color[red]>" to_console
        - determine cancelled if:<server.has_flag[joined.<context.address>].not>
        after player joins:
        - define ip <player.ip_address>
        - flag server joined.<player>:<server.flag[joined.<player>].include[<[ip]>].deduplicate>
        - flag server joined.<[ip]>:<server.flag[joined.<[ip]>].include[<player>].deduplicate||<list>>
        - flag player ip_address:->:<[ip]>
        - flag player ip_address:<player.flag[ip_address].deduplicate>
        - announce "<[ip]> -<&gt> <player.name>"                                                                                to_console format:center
        - announce "<element[<&lb>Addresses assocated with player<&rb>].color[blue]>: <server.flag[joined.<player>].formatted>" to_console format:center
        - announce "<element[<&lb>Names assocated with address<&rb>].color[blue]>: <server.flag[joined.<[ip]>].formatted||>"    to_console format:center
On_Ping_MAX_PLAYERS:
    type: world
    enabled: true
    debug: false
    events:
        on server list ping:
        - determine <script[on_ping_config].data_key[MAX_PLAYERS]>
On_Ping_MOTD:
    type: world
    enabled: true
    debug: false
    events:
        on server list ping:
        - determine <script[on_ping_config].data_key[MOTD]>
On_Ping_PLAYERS:
    type: world
    enabled: true
    debug: false
    events:
        on server list ping:
        - determine EXCLUDE_PLAYERS:<script[on_ping_config].data_key[EXCLUDE_PLAYERS]>
On_Ping_PROTOCOL_VERSION:
    type: world
    enabled: true
    debug: false
    events:
        on server list ping:
        - determine PROTOCOL_VERSION:<script[on_ping_config].data_key[PROTOCOL_VERSION]>
On_Ping_VERSION_NAME:
    type: world
    enabled: true
    debug: false
    events:
        on server list ping:
        - determine VERSION_NAME:<script[on_ping_config].data_key[VERSION_NAME]>
On_Ping_ICON:
    type: world
    enabled: true
    debug: false
    events:
        on server list ping:
        - determine ICON:<script[on_ping_config].data_key[ICON]>