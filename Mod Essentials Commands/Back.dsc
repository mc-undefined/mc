Back_Command:
    type: command
    enabled: true
    debug: false
    name: back
    description: Teleports to location before last teleport.
    tab completions:
        1: <server.online_players.parse[name]>
        default: StopTyping
    usage: /back [player]
    data:
        dyn:
        - You can now go back to your last location! ./back <player.name>
    script:
    - define entity <context.args.get[1]||<player||>>
    - narrate "Teleporting you back to your last location." format:notice
    - teleport <[entity]> <[entity].flag[teleport_history]> cause:COMMAND relative if:<[entity].has_flag[teleport_history]||false>

Record_Entity_Teleports:
    type: world
    debug: false
    enabled: true
    data:
        dyn:
        - The server now keeps just 1 teleport history for each entity. And that includes players deaths!
        teleport_reasons:
        - PLUGIN
        - COMMAND
    events:
        after player joins:
        - flag <player> teleport_history:<player.location> if:<player.has_flag[teleport_history].not>
        on player death:
        - flag <player> teleport_history:<player.location>
        after entity teleports:
        - flag <context.entity> teleport_history:<context.origin> if:<script.data_key[data.teleport_reasons].contains[<context.cause>]>