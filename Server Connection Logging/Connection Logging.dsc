On_Connection_Logging:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - The server appears offline untill you join the server. This is for connection loggers that check if the server is running.
        - Your Ip address is associated with your UUID and your UUID is associated with your IP address.
        MOTD: Your npcs are starving!
        on_connection:
            VERSION: 1.20.2
            VERSION_NAME: Paper!
            ICON: <empty>
            PROTOCOL_VERSION: 764
            EXCLUDE_PLAYERS: <server.online_players>
            ALTERNATE_PLAYER_TEXT: <empty>
    events:
        on server list ping:
        - define id <server.flag[joined.<context.address>].deduplicate.parse[name].formatted||<context.address>>
        - announce "[<element[ping].color[yellow]>] [<element[Protocol].color[blue]>: <context.protocol_version>] [<element[client_version].color[blue]>: <context.client_protocol_version||None>] Names from adress: <[id].color[red]>" to_console
        - if <server.has_flag[joined.<context.address>].not>:
            - determine cancelled
        #- determine <script.data_key[data.on_connection.MOTD]> "icon:<script.data_key[data.on_connection.icon]> protocol_version:<script.data_key[data.on_connection.protocol_version]> version_name:<script.data_key[data.on_connection.version_name]> exclude_players:<script.data_key[data.on_connection.exclude_players]>" 
        - determine <script.data_key[data.MOTD]> <script.data_key[data.on_connection].to_pair_lists.parse_tag[<[parse_value].separated_by[<&co>]>].separated_by[<&sp>]>

        after player joins:
        - wait 1t
        - define ip <player.ip_address>
        - flag server joined.<player>:<server.flag[joined.<player>].include[<[ip]>].deduplicate>
        - flag server joined.<[ip]>:<server.flag[joined.<[ip]>].include[<player>].deduplicate||<list>>
        - flag player ip_address:->:<[ip]>
        - flag player ip_address:<player.flag[ip_address].deduplicate>
        - announce "<[ip]> -<&gt> <player.name>"                                                                                to_console format:center
        - announce "<element[<&lb>Addresses assocated with player<&rb>].color[blue]>: <server.flag[joined.<player>].formatted>" to_console format:center
        - announce "<element[<&lb>Names assocated with address<&rb>].color[blue]>: <server.flag[joined.<[ip]>].formatted||>"    to_console format:center
