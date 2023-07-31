Command_Warp:
    type: command
    debug: false
    name: warp
    description: Sets a noted location to warp to.
    usage: /warp (notable_cuboid)
    tab completions:
        1: <util.notes[cuboids].parse[note_name]>
    data:
        dyn:
        - The ./warp location command comes from the notable cuboid series of scripts?
    script:
    - define target <cuboid[<context.args.get[1]>]||null>
    - choose <[target]>:
        - case null:
            - narrate "<gray>Options are: <blue><util.notes[cuboids].parse[note_name].formatted>" format:notice
            - stop
        - default:
            - narrate "Teleporting to: <red><[target].note_name>" format:notice
            - teleport <player> <[target].spawnable_blocks.random.highest>

Command_Tp_Notification:
    type: world
    debug: false
    data:
        dyn:
        - If you havnt noticed, ./tp is now compatible with minecraft mods that use the command.
        - Have you used ./warp location yet?
    events:
        after tp command:
        - narrate "<gray>If your looking for ./tp notable use ./warp notable" format:center