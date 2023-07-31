Notable:
    type: command
    enabled: true
    debug: false
    name: note
    description: Creates an entry in the server database for a cuboid notable.
    tab completions:
        1: add|remove
        2: <list[UniqueName].include[<util.notes[cuboids].parse[note_name]||>]>
        3: <proc[get_detectable_structures].context[<player.location>].parse_tag[<[parse_value].get[structure]>]||<server.structure_types>>
        default: StopTyping
    usage: /note [add|remove] [UniqueName] [Structure_type]
    data:
        dyn:
        - ./note to add a notable cuboid to the server! Please leave for admin use though. :/
    script:
    - define function <context.args.get[1]>
    - define name <context.args.get[2]>
    - define structure <context.args.get[3].if_null[null]>
    - define dynmap? <server.plugins.contains_any[<plugin[dynmap]>]>
    - define num_notes <util.notes[cuboids].size>
    - choose <[function]>:
        - case add:
            - inject <script> path:add
        - case remove:
            - inject <script> path:remove
        - default:
            - narrate "<red>Please choose add or remove for notables." format:notice
            - narrate <gray><script.data_key[usage]> format:center

    add:
    - if <[structure]> == null:
        - narrate "<gray>You need a specified type argument." format:notice
        - stop
    - if <util.notes[cuboids].contains_any[<cuboid[<[name]>]>]>:
        - narrate "<gray>This cuboid already exists!" format:notice
        - stop
    - execute as_player "dmarker add <[name]> icon:<[structure]>" if:<[dynmap?]>
    - note <player.location.chunk.cuboid> as:<[name]>
    - define cub <cuboid[<[name]>]>
    - announce "<blue>Noted: <yellow><[cub].note_name.to_sentence_case> <blue>type: <yellow><[structure]>" format:notice
    - narrate "<blue>Number of notables: <yellow><[num_notes]><element[-<&gt>].color[green]><util.notes[cuboids].size>" format:center
    - showfake glowstone <[cub].outline> players:<server.online_players>
    remove:
    - execute as_player "dmarker delete label:<[name]>" if:<[dynmap?]>
    - note remove as:<[name]>
    - announce "<blue>Removed noted: <yellow><[name]>" format:notice
    - narrate "<blue>Number of notables: <yellow><[num_notes]><element[-<&gt>].color[green]><util.notes[cuboids].size>" format:center

Notable_Entry:
    type: world
    enabled: true
    debug: false
    data:
        dyn:
        - Some places, when you enter, have special effects and triggers when you enter!
    events:
        on entity enters cuboid:
        - ratelimit <context.entity> 10s
        - define name <context.area.note_name.if_null[<context.area>]>
        - announce "<context.entity.name> is entering: <[name].to_sentence_case>"
        on entity exits cuboid:
        - ratelimit <context.entity> 10s
        - define name <context.area.note_name.if_null[<context.area>]>
        - announce "<context.entity.name> is exiting: <[name].to_sentence_case>"

Convert_Existing_Notables_Into_Cuboids:
    type: task
    enabled: true
    definitions: notable
    data:
        dyn:
        - The server uses Dynmap to display location and notable cuboids!
    script:
    - define index <util.notes.find_partial[<[notable]>]>
    - define note <util.notes.get[<[index]>].if_null[null]>
    - if <[note]> == null:
        - narrate "Could not find notable: <[notable]>"
        - stop
    - define name <[note].note_name>
    - define cuboid <[note].chunk.cuboid>
    - narrate "<gold>please say 'stop' to stop converting <[name]>."
    - wait 10s
    - if <player.chat_history.contains[stop]>:
        - narrate "<gold>stopping procedure to remove and recreate notable: <[name]>"
        - stop
    - note remove as:<[note]>
    - note <[cuboid]> as:<[name]>
    - announce "<gold>Renoted area: <[name]>"
    # Need to detect tye type of old notables
    # Need to remap the actual notables to the icon available

Notable_Point_Converter:
    type: task
    debug: false
    enabled: true
    data:
        dyn:
        - I recently tried to convert locations into cuboids for enabling area effects!
    script:
    - foreach <util.notes[locations]>:
        - define name <[value].note_name>
        - define cuboid <[value].chunk.cuboid>
        - define data <proc[Get_Nearest_Structure].context[<[value]>]>
        - define type <[data.structure]>
        - announce "<red>Converting Notable:<yellow><[name]> <red>type:<yellow><[type]>"
        - note remove as:<[value]>
        - note <[cuboid]> as:<[name]>
        - flag <[cuboid]> type:<[type]>

Get_Detectable_Structures:
    type: procedure
    debug: false
    definitions: location|distance
    script:
    - define distance <[distance]||0>
    - define locations <list[]>
    - foreach <server.structure_types>:
        - definemap data:
            structure: <[value]>
            location: <[location].find.structure[<[value]>].within[<[distance]>]||null>
        - if <[data.location].is[==].to[null].not>:
            - define locations:->:<[data]>
    - determine <[locations]>

Get_Nearest_Structure:
    type: procedure
    debug: false
    definitions: location
    script:
    - define current_distance 999999
    - definemap data:
        distance: null
        location: null
        structure: null
    - foreach <proc[get_detectable_structures].context[<[location]>]>:
        - define target_distance <[location].distance[<[value.location]>]>
        - if <[target_distance].is[less].than[<[current_distance]>]>:
            - define value.distance <[target_distance]>
            #FIXME: Search provides a height of 0
            - define value.location <[value.location].highest>
            - define data <[value]>
    - determine <[data]>