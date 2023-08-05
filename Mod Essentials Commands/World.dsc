Command_World:
    type: command
    debug: false
    name: world
    description: Teleports to a worlds spawn.
    usage: /world [world]
    tab completions:
        1: <server.worlds.parse[name]>
    data:
        dyn:
        - The ./world [name] teleports you to the world's location?
    script:
    - define world <world[<context.args.get[1]>]||null>
    - choose <[world]>:
        - case null:
            - narrate "<gray>Options are: <blue><server.worlds.formatted>" format:notice
            - stop
        - default:
            - narrate "Teleporting to: <red><[world]>" format:notice
            - teleport <player> <[world].spawn_location.chunk.cuboid.spawnable_blocks.random.highest>
