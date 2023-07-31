Server_Lag:
    type: command
    debug: false
    name: lag
    description: Returns server TPS, and if wanted suggest clearing memory and reset stats.
    usage: /lag (No arguments)
    permission message: How do you not have permission? Contact an admin and notify them.
    tab complete:
    - determine free_memory
    data:
        dyn:
        - Feeling laggy? Have you checked with the ./lag command?
        - Ticks Per Second or ./lag is a command use to check server health.
    script:
    - midi file:heartbeat.mid
    - choose <context.args.get[1]>:
        - case free_memory:
            - narrate "<red>Before <blue>freeing memory."
            - run narrate_serverstats
            - narrate "<blue>Freeing up memory and reseting event data."
            - adjust system cleanmem
            - adjust system reset_event_stats
            - narrate "<blue>After freeing memory."
            - run narrate_serverstats
        - default:
            - run narrate_serverstats

Narrate_ServerStats:
    type: task
    enabled: true
    debug: false
    script:
    - narrate <&nl>
    - narrate "<blue>Event Stats: <reset><util.event_stats>"
    - narrate "<blue>Started time: <reset><util.started_time>"
    - narrate "<blue>Last Reload: <reset><util.last_reload>"
    - narrate "<blue>Disk Usage: <reset><util.disk_usage.div[1074000000].format_number[00.0]> <blue>GB"
    - narrate "<blue>Disk Free: <reset><util.disk_free.div[1074000000].format_number[00.0]> <blue>GB"
    - narrate "<blue>Disk Total: <reset><util.disk_total.div[1074000000].format_number[00.0]> <blue>GB"
    - narrate "<blue>Ram Max: <reset><util.ram_max.div[1074000].format_number[00.0]> <blue>MB"
    - narrate "<blue>Ram Allocated: <reset><util.ram_allocated.div[1074000].format_number[00.0]> <blue>MB"
    - narrate "<blue>Ram Usage: <reset><util.ram_usage.div[1074000].format_number[00.0]> <blue>MB"
    - narrate "<blue>Ram Free: <reset><util.ram_free.div[1074000].format_number[00.0]> <blue>MB"
    - narrate "<blue>Server TPS: <reset><server.recent_tps.parse_tag[<[parse_value].format_number[00.0]>]>"
    - narrate "<blue>Your <yellow>Ping<blue>: <red><player.ping>"