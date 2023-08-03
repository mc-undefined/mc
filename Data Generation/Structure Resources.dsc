Record_World_Structures:
    type: world
    debug: true
    enabled: true
    data:
        notable_types:
        - spawn
        - <server.structure_types>
        - scenic
        - build
    events:
        after server start:
        - flag server notable_types:<script.data_key[data.notable_types]>

Get_Structures:
    type: procedure
    debug: true
    definitions: location|distance
    script:
    - define distance <[distance]||0>
    - define locations <list[]>
    - foreach <server.structure_types>:
        - define name <util.random.duuid>
        - definemap data:
            structure: <[value]>
            location: <[location].find.structure[<[value]>].within[<[distance]>]||null>
            name: <[name].substring[7,<[name].length>]>
        - define data <[data].include[distance=<[location].distance[<[data.location]>]||null>]>
        - if <[data.location].is[==].to[null].not>:
            - define locations:->:<[data]>
    - determine <[locations]>

Get_Nearest_Structure:
    type: procedure
    debug: false
    definitions: location
    script:
    - define current_distance 99999999
    - definemap data:
        distance: null
        location: null
        structure: null
        name: null
    - foreach <proc[Get_Structures].context[<[location]>]>:
        - define target_distance <[location].distance[<[value.location]>]>
        - if <[target_distance].is[less].than[<[current_distance]>]>:
            - define value.distance <[target_distance]>
            #FIXME: Search provides a height of 0
            - define value.location <[value.location].highest>
            - define data <[value]>
            #- announce "<[value]>"
    - determine <[data]>

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
        - debug debug "<red><script.name>: <yellow><[name]> <red>type:<yellow><[type]>"
        - note remove as:<[value]>
        - note <[cuboid]> as:<[name]>
        - flag <[cuboid]> type:<[type]>

Record_Structure:
    type: task
    debug: true
    enabled: true
    #definitions: structure[A structure dict from Get_Structure task]
    script:
    - foreach <queue.definition_map> key:id as:structure:
        - if <[structure.location].is[==].to[null]||true>:
            - debug debug "<script.name> Structure was: <[structure]>"
            - foreach next
        - define cub3 <[structure.location].chunk.cuboid>
        - define cuboids <[structure.location].areas[cuboid]>
        - if <[cuboids].is_empty.not>:
            - debug debug "<script.name> Area already has <[cuboids].formatted>"
            - foreach next
        - run addremove_noted_cuboid def:add|<[cub3]>|<[structure.name]>

Record_gotten_structures:
    type: task
    debug: true
    enabled: true
    data:
        dyn:
        - We record all villages, forts, portals on the server and offer teleport services to them!
    #definitions: structure1, structure2,...., structure n
    script:
    - stop