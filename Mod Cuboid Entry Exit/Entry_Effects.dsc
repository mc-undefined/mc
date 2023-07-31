Notable_Entry_Effects:
    type: world
    enabled: true
    debug: false
    events:
        on entity enters cuboid:
        - ratelimit <context.entity> 10s
        - define name <context.area.note_name.if_null[null]>
        - if <[name]> == null:
            - stop
        - if !<context.area.has_flag[entry.effect]>:
            - stop
        #- announce "Areas deep keys: <context.area.flag[entry].deep_keys.formatted>"
        - foreach <context.area.flag[entry.effect].keys>:
            - define key entry.effect.<[value]>
            - define effect <context.area.flag[<[value]>]>
            - define time <context.area.flag[<[key]>.time]>
            - define strength <context.area.flag[<[key]>.strength]>
            #- announce "Casting: <[value]> time:<[time]> strength:<[strength]>"
            - cast <[value]> duration:<[time]> amplifier:<[strength]> <context.entity>
        on entity exits cuboid:
        - ratelimit <context.entity> 10s
        - define name <context.area.note_name.if_null[null]>
        - if <[name]> == null:
            - stop
        # - announce ""
        # - announce "<context.entity.name> is exiting: <[name]>"

Notable_Entry:
    type: world
    enabled: false
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
