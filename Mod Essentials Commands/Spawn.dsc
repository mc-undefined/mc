Spawn_Command:
    type: command
    enabled: true
    debug: false
    name: spawn
    description: Spawns target to spawn cuboid.
    tab completions:
        1: <server.online_players.parse[name]>
        default: StopTyping
    usage: /spawn [player]
    data:
        dyn:
        - ./spawn <player.name> to teleport <player.name> spawn
    script:
    - narrate "Teleporting you to spawn." format:notice
    - teleport <context.args.get[1]||<player||>> <cuboid[spawn].spawnable_blocks.random||<player.location.world.spawn_location||>> cause:COMMAND

SetSpawn_Command:
    type: command
    enabled: true
    debug: false
    name: setspawn
    description: Sets the world spawn cuboid.
    tab completions:
        default: StopTyping
    usage: /setspawn
    data:
        dyn:
        - ./setspawn to set spawn
    script:
    - run addremove_noted_cuboid def:remove|<empty>|<cuboid[spawn]>
    - run addremove_noted_cuboid def:add|<player.location.chunk.cuboid>|spawn
    - adjust <player.location.world> spawn_location:<player.location>