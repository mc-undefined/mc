Command_Notable:
    type: command
    enabled: true
    debug: false
    name: note
    description: Creates an entry in the server database for your current location.
    tab completions:
        1: add|remove|modify
        2: UniqueName|<util.notes[cuboids].parse[note_name]||<list[]>>
        default: StopTyping
    usage: /note [add|remove|modify] [UniqueName]
    data:
        dyn:
        - ./note to [add|remove|modify] a notable cuboid to the server!
    script:
    - run <script[addremove_noted_cuboid]> def:<context.args.get[1]>|<player.location.chunk.cuboid>|<context.args.get[2]>

AddRemove_Noted_Cuboid:
    type: task
    debug: false
    enabled: true
    definitions: function[Add, Remove, Modify]|cub3[A DCuboid]|name[Unique name, Existing notable]
    script:
    - define dynmap? <server.plugins.contains_any[<plugin[dynmap]||>]||false>
    - define num_notes <util.notes[cuboids].size>
    - choose <[function]>:
        - case add:
            - inject <script> path:add
        - case remove:
            - inject <script> path:remove
        - case modify:
            - inject <script> path:modify
        - default:
            - narrate "<red>Please choose add, remove, or modify for notables." format:notice
            - narrate <gray><script[notable].data_key[usage]> format:center
            - stop
    - narrate "<green><element[Number of notables].color[blue]>: <[num_notes]> <element[is now:].color[blue]> <util.notes[cuboids].size>" format:center
    modify:
    - debug error "<script.name>: TODO: needs a modify cause."
    add:
    - if <[cub3]> == null:
        - narrate "<gray>You need a cuboid." format:notice
        - stop
    - if <util.notes[cuboids].contains_any[<cuboid[<[name]>]||>]>:
        - narrate "<script.name>: <gray>This cuboid[<cuboid[<[name]>]||>] already exists!" format:notice
        - stop
    - execute as_player "dmarker add <[name]> icon:<[structure]>" if:<[dynmap?]>
    - note <[cub3]> as:<[name]>
    - define cub <cuboid[<[name]>]>
    - announce "<yellow><element[Noted].color[blue]>: <[cub].note_name.to_sentence_case>" format:notice
    - showfake glowstone <[cub].outline> players:<server.online_players>
    remove:
    - execute as_player "dmarker delete label:<[name]>" if:<[dynmap?]>
    - note remove as:<[name]>
    - announce "<blue>Removed noted: <yellow><[name]>" format:notice

