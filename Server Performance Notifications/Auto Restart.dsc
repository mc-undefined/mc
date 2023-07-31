#https://paste.denizenscript.com/View/102704
auto_restarter_world:
    type: world
    debug: false
    enabled: false
    events:
        on system time 03:00:
        - run auto_restarter_task
        on player logs in server_flagged:restart_happening:
        - determine "KICKED:Server is restarting momentarily, please wait."

auto_restarter_task:
    type: task
    debug: false
    script:
    - wait 1m
    - define marks <list[30m|20m|15m|10m|5m|4m|3m|2m|1m|30s|15s|10s|5s].parse[as[duration]]>
    - foreach <[marks]> as:mark:
        - if <server.online_players.is_empty>:
            - foreach stop
        - announce "<&c>Server will automatically restart in <[mark].formatted_words>."
        - if <[mark].in_seconds> <= 60:
            - title "subtitle:<&c>Restart in <[mark].formatted_words>." fade_out:10s targets:<server.online_players>
            - flag server restart_happening duration:<[mark].add[10s]>
        - wait <[mark].sub[<[marks].get[<[loop_index].add[1]>]||0s>]>
    - flag server restart_happening duration:5s
    - announce "<&c>Server RESTARTING NOW!"
    - kick <server.online_players> "reason:Restarting! Please wait a minute before rejoining."
    - wait 1s
    - adjust server restart