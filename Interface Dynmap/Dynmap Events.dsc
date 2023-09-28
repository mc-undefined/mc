Dynmap_Updates:
    type: world
    enabled: false
    debug: true
    data:
        dyn:
        - We try to highlight all villages, dungeons, and special areas in dynmap.
    events:
        after chunk loads ENTITIES entity_type:VILLAGER:
        - ratelimit server 1s
        - actionbar "Chunk loaded a <context.entities.parse[name].formatted> into the world!" targets:<server.online_players>
        - cast GLOWING duration:30s amplifier:10 <context.entities>

        after VILLAGER added to world:
        - ratelimit server 1t
        - if !<script.data_key[debug]>:
            - stop
        - announce "Added a <context.entity.name> into the world!" format:DebugPrefix
        #- announce "Villager had: <context.entity.has_attribute[Brain.memories]>"
        #- cast GLOWING duration:30s amplifier:10 <context.entity>


Dynmap_Add_Notable:
    type: task
    definitions: notable
    data:
        dyn:
        - An admin created a script to autoconvert all notable locations into areas in Dynmap. He failed.
    script:
    - define index <util.notes[cuboids].find_partial[<[notable]>]>
    - define note <util.notes[cuboids].get[<[index]>].if_null[null]>
    - if <[note]> == null:
        - narrate "Could not find notable: <[notable]>"
        - narrate "Did you mean: <util.notes[locations].closest_to[<[note]>]>?"
        - stop
    - announce "Found: <[note]>"

    - define cmd "dmarker deletearea 'id:<[note].note_name>'"
    - announce <[cmd]>
    - execute as_server <[cmd]> save:output
    - announce <entry[output].output.formatted>

    - define cmd "dmarker addcorner <[note].min.x> <[note].min.y> <[note].min.z> <[note].min.world.name>"
    - announce <[cmd]>
    - execute as_server <[cmd]> save:output
    - announce <entry[output].output.formatted>

    - define cmd "dmarker addcorner <[note].max.x> <[note].max.y> <[note].max.z> <[note].max.world.name>"
    - announce <[cmd]>
    - execute as_server <[cmd]> save:output
    - announce <entry[output].output.formatted>

    - define cmd "dmarker addarea 'id:<[note].note_name.to_titlecase>'"
    - announce <[cmd]>
    - execute as_server <[cmd]> save:output
    - announce <entry[output].output.formatted>

    - define cmd "dmarker clearcorners"
    - announce <[cmd]>
    - execute as_server <[cmd]> save:output
    - announce <entry[output].output.formatted>

Dynmap_Add_All_Notables:
    type: task
    enabled: true
    debug: true
    script:
    - foreach <util.notes[cuboids]>:
        - wait 1s
        - run Dynmap_Add_Notable def:<[value]>

Dmarkers_list:
    # Convert icons into notable locations
    type: task
    debug: true
    script:
    - execute as_server "dmarker list" save:markers
    - define markers <entry[markers].output>
    #- define list "<gold><[markers].get[2].split[, ].to_map[<&co>]>"
    #- announce "<gold><[list]>"
    - foreach <[markers]>:
        - wait 1t
        - define mmap <[markers].get[2].split[, ].to_map[<&co>]>
        - definemap data:
            id: "<[value].split[, ].split[<&co>].get[1]>"
            label: "<[value].split[, ].split[<&co>].get[3].as_list.get[1].replace[<&dq>].with[].trim>"
            location: <element[<[mmap].get[x]>,<[mmap].get[y]>,<[mmap].get[z]>,<[mmap].get[world]>].as_location>
            icon: <[mmap].icon>
            location_near: <proc[Get_Nearest_Structure].context[<[location]>]>
            type: <proc[Get_Nearest_Structure].context[<[data.location]>]>
        - note <[data.location]> as:<[data.label]>
        - flag <[data.label]> icon:<[data.icon]>
        - flag <[data.label]> type:<[data.type].get[type]>
        #- execute as_server "dmarker delete id:<[data.id]>"
        - announce "<gold>Noted: <gray><[data.type].get[type]> <gold>Labeled: <gray><[data.label]> <gold>at: <gray><[data.location]>"

