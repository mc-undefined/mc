On_Connection_Logging:
    type: world
    enabled: true
    debug: false
    data:
        VERSION: 1.19.4
        ICON: <empty>
        PROTOCOL_VERSION: 762
        EXCLUDE_PLAYERS: <server.online_players>
        ALTERNATE_PLAYER_TEXT: <empty>
        MOTD: Another Minecraft Server
    events:
        on server list ping:
        - define id <server.flag[joined.<context.address>].deduplicate.parse[name].formatted||<context.address>>
        - announce "[<element[ping].color[yellow]>] [<element[Protocol].color[blue]>: <context.protocol_version>] Names from adress: <[id].color[red]>" to_console
        - if <server.has_flag[joined.<context.address>].not>:
            - determine cancelled
        after player joins:
        - wait 1t
        - define ip <player.ip_address>
        - flag server joined.<player>:<server.flag[joined.<player>].include[<[ip]>].deduplicate>
        - flag server joined.<[ip]>:<server.flag[joined.<[ip]>].include[<player>].deduplicate||<list>>
        - flag player ip_address:|:<[ip]>
        - flag player ip_address:<player.flag[ip_address].deduplicate>
        - announce "<[ip]> -<&gt> <player.name>"                                                                                to_console format:center
        - announce "<element[<&lb>Addresses assocated with player<&rb>].color[blue]>: <server.flag[joined.<player>].formatted>" to_console format:center
        - announce "<element[<&lb>Names assocated with address<&rb>].color[blue]>: <server.flag[joined.<[ip]>].formatted||>"    to_console format:center