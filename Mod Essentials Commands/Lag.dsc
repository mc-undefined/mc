Command_Lag:
    type: command
    debug: false
    name: lag
    description: Returns server TPS, and if wanted suggest clearing memory and reset stats.
    usage: /lag [free_memory]
    permission message: How do you not have permission? Contact an admin and notify them.
    tab complete:
    - determine free_memory
    data:
        dyn:
        - Feeling laggy? Have you checked with the ./lag command?
        - Ticks Per Second or ./lag is a command use to check server health.
    script:
    - nbs play file:nbs/lag_heartbeat
    - choose <context.args.get[1]||null>:
        - case free_memory:
            - narrate "<red>Before <blue>freeing memory." format:notice
            - run narrate_serverstats
            - narrate "<blue>Freeing up memory and reseting event data." format:notice
            - adjust system cleanmem
            - adjust system reset_event_stats
            - narrate "<blue>After freeing memory." format:notice
            - run narrate_serverstats
        - default:
            - run narrate_serverstats

Narrate_ServerStats:
    type: task
    enabled: true
    debug: false
    script:
    - narrate "<blue>Event Stats: <reset><util.event_stats>" format:notice
    - narrate "<blue>Started time: <reset><util.started_time>" format:center
    - narrate "<blue>Last Reload: <reset><util.last_reload>" format:center
    - narrate "<blue>Disk Usage: <reset><util.disk_usage.div[1074000000].format_number[00.0]> <blue>GB" format:center
    - narrate "<blue>Disk Free: <reset><util.disk_free.div[1074000000].format_number[00.0]> <blue>GB" format:center
    - narrate "<blue>Disk Total: <reset><util.disk_total.div[1074000000].format_number[00.0]> <blue>GB" format:center
    - narrate "<blue>Ram Max: <reset><util.ram_max.div[1074000].format_number[00.0]> <blue>MB" format:center
    - narrate "<blue>Ram Allocated: <reset><util.ram_allocated.div[1074000].format_number[00.0]> <blue>MB" format:center
    - narrate "<blue>Ram Usage: <reset><util.ram_usage.div[1074000].format_number[00.0]> <blue>MB" format:center
    - narrate "<blue>Ram Free: <reset><util.ram_free.div[1074000].format_number[00.0]> <blue>MB" format:center
    - narrate "<blue>Server TPS: <reset><server.recent_tps.parse_tag[<[parse_value].format_number[00.0]>].formatted>" format:center
    - narrate "<blue>Your <yellow>Ping<blue>: <red><player.ping>" format:center